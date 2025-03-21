class Visitor < ApplicationRecord
    has_many :visits



    def get_data
        visits = self.visits


        links = {
            "http://localhost:5173/" => "Portfolio Site",
            "resume_link" => "Resume Link",
            "https://chess-hfx7.onrender.com" => 'Chess App', 
            "https://movie-battle.onrender.com" => "Movie Battle App",  
            "https://twitter-clone-frontend-q1pw.onrender.com" => "Twitter Clone App",
            'https://github.com/andrew-wulf/twitter-clone-frontend' => "Twitter Clone Github",
            'https://github.com/andrew-wulf/movie_battle' => "Movie Battle Github",
            'https://github.com/andrew-wulf/chess' => "Chess Github"
        }

        data = {}
        links.values.each {|v| data[v] = []}

        visits.each do |visit|
            site = visit.site
            if links.keys.include?(site)
                data[links[site]].push(visit.created_at.in_time_zone("America/Chicago").strftime('%m/%d %I:%M%p'))
            end
        end

        return data
    end
end
