class LobbiesController < ApplicationController


  def create

    letters = ('A'..'Z').to_a
    code = ''

    4.times do
      code += letters[rand(26)]
    end

    @lobby = Lobby.new(code: code)
    @lobby.save

    render :show
  end


  def view
    @lobby = Lobby.find_by(code: params[:code])

    render :show
  end

  def index
    @lobbies = Lobby.all

    render :index
  end


  def add_player
    @lobby = Lobby.find_by(code: params[:code])

    res = @lobby.add(params[:player_name])

    if res == 1
      render json: {message: 'Name Taken.'}
    elsif res == 2
      render json: {message: 'Lobby is full.'}
    else
     render :show
    end
  end


  def remove_player
    @lobby = Lobby.find_by(code: params[:code])

    res = @lobby.remove(params[:player_name])

    if res
      render :show
    else
      render json: {message: 'player not found.'}
    end
  end

end
