class TweetsController < ApplicationController
  before_action :authenticate_user, only: [:timeline]

  def show
    @tweet = Tweet.find_by(id: params[:id])
    render :show
  end

  def user_tweets
    user = User.find_by(username: params[:username])

    offset, limit = params[:offset] || 0, params[:limit] || 50

    if user
      @tweets = user.content(offset, limit)
      render :index
    else
      render json: {error: 'User id not found.'}
    end
  end

  def timeline
    offset, limit = params[:offset] || 0, params[:limit] || 50

    @tweets = current_user.timeline(offset, limit)
    render :index
  end

end
