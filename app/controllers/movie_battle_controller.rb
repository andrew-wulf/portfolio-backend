class MovieBattleController < ApplicationController

  
  def search()
    
    term = params[:term]
    type = params[:type] || 'movie'

    @base_url = ENV['THEMOVIEDB_BASE_URL']
    @api_key = ENV['THEMOVIEDB_API_KEY']
    @access_token = ENV['THEMOVIEDB_ACCESS_TOKEN']

    if not term
      return nil
    end

    search_params = { 'api_key' => @api_key, 'query' => term }

    if type == 'person'
      search_url = URI("#{@base_url}/search/person")
    elsif type == 'movie'
      search_url = URI("#{@base_url}/search/movie")
    else
      return nil
    end

    output = []

    search_url.query = URI.encode_www_form(search_params)
    #pp search_url
    response = Net::HTTP.get_response(search_url)

    data = JSON.parse(response.body)
    if data['results'].any?
      if type == 'person'
        return data['results'][0]
      end

      i, return_index = 0, -1
      while output.length < 15 && i < data['results'].length
        curr_movie = data['results'][i]
        if curr_movie['release_date'].length > 0
          output.push({id: curr_movie['id'], title: curr_movie['title'], release_date: curr_movie['release_date']})
        end
        i +=1
      end
    end
    render json: output
  end



  def movie_data()
    id = params[:id]
    auto = params[:auto] || false

    @base_url = 'https://api.themoviedb.org/3'
    @api_key = ENV['THEMOVIEDB_API_KEY']
    @access_token = ENV['THEMOVIEDB_ACCESS_TOKEN']

    #pp info

    search_params = { 'api_key' => @api_key }
    search_url = URI("#{@base_url}/movie/#{id}/credits?language=en-US")

    search_url.query = URI.encode_www_form(search_params)
    response = Net::HTTP.get_response(search_url)
    data = JSON.parse(response.body)
    output = {}

    if data
      output = {director: [], screenplay: [], cinematographer: [], composer: [], editor: [], cast: []}

      for row in data['crew']
        job = row['job']
        #pp job
        for title in output.keys
          t = title.to_s
          if t == 'cinematographer'
            t = "director of photography"
          elsif t == 'composer'
            t = "original music composer"
          end

          if job.downcase == t
            output[title].push(row['name'])
          end
        end
      end

      cast = data['cast']

      i = 0
      while i < 50 && i < cast.length
        output[:cast].push([cast[i]['name'], cast[i]['character']])
        i +=1
      end
    end
    render json: output
  end



  def in_blacklist?(person, blacklist)
    blacklist.each do |n| 
      if n == person
        #pp [n, person]
        return true
      end
    end
    return false
  end


  
  def compare_movies()
    movie1_data = params[:movie1_data]
    movie2_data = params[:movie2_data]
    blacklist = params[:blacklist] || nil
    hard_mode = params[:hard_mode] || false

    if not blacklist
      blacklist = []
    end
    #pp blacklist

    first_match = nil

    i = 1
    while i < movie1_data.keys.length
      key = movie1_data.keys[i]

      for person in movie1_data[key]
        if key == :cast
          person, role = person[0], person[1]
        end

        for title in [:director, :screenplay, :cinematographer, :composer, :editor]
          for crew in movie2_data[title]
            if crew == person
              if hard_mode
                if in_blacklist?(crew, blacklist)
                  render json: {result: ['fail', crew, 'fail', title.to_s]}
                  return
                elsif not first_match
                  first_match = [crew, key, title.to_s]
                end
              else
                render json: {result: ['success', crew, key, title.to_s]}
                return
              end
            end
          end
        end

        for actor in movie2_data[:cast]
          if actor[0] == person 
            if hard_mode
              if in_blacklist?(actor[0], blacklist)
                render json: {result: ['fail', actor[0], 'blacklisted', actor[1]]}
                return
              elsif not first_match
                first_match = [actor[0], role, actor[1]]
              end
            else
              render json: {result: ['success', actor[0], role, actor[1]]}
              return
            end            
          end
        end
      end
    
      i +=1
    end

    if first_match
      render json: {result: ['success', ...first_match]}
    else
      render json: {result: ['fail', nil]}
    end
  end



end
