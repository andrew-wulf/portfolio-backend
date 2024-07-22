class TweetsController < ApplicationController
  before_action :authenticate_user, only: [:timeline, :create, :like_toggle, :retweet_toggle]


  def create
    @tweet = Tweet.new(user_id: current_user.id, text: params[:text], image: params[:image], video: params[:video])
    @tweet.save
    if @tweet.save
      @tweet.update(timestamp: @tweet.created_at) 
      render :show
    else
      render json: {error: @tweet.errors}
    end
  end

  def show
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet
      @tweet.view
      @current_user = current_user
      render :show
    else
      render json: {error: 'tweet not found.'}
    end
  end

  def subtweet
    tweet = Tweet.find_by(id: params[:tweet_id])

    if tweet
      @tweet = Tweet.new(user_id: current_user.id, text: params[:text], image: params[:image], video: params[:video], is_subtweet: true)
      if @tweet.save
        @tweet.update(timestamp: @tweet.created_at) 

        s = Subtweet.new(tweet_id: tweet.id, sub_id: @tweet.id)
        if s.save
          @tweet.reply_count +=1
          @tweet.save
          render :show
        else
          @tweet.destroy
          render json: {error: s.errors}
        end
      else
        render json: {error: @tweet.errors}
      end
    else
      render json: {error: 'tweet not found.'}
    end
  end


  def user_tweets
    @current_user = current_user
    user = User.find_by(username: params[:username])

    offset, limit = params[:offset] || 0, params[:limit] || 50

    if user
      @tweets = user.content(offset, limit)
      @tweets.each do |tweet|
        if tweet.attributes['text']
         tweet.view
        end
      end
      render :index
    else
      render json: {error: 'Username not found.'}
    end
  end

  def timeline
    offset, limit = params[:offset] || 0, params[:limit] || 20

    @current_user = current_user
    @tweets = @current_user.timeline(offset, limit)
    @tweets.each do |tweet|
      if tweet.attributes['text']
       tweet.view
      end
    end
    render :index
  end

  def suggested
    offset, limit = params[:offset] || 0, params[:limit] || 20

    @current_user = current_user
    @tweets = @current_user.suggested_tweets(offset, limit)
    @tweets.each do |tweet|
      if tweet.attributes['text']
       tweet.view
      end
    end
    render :index
  end

  def liked_tweets
    user = User.find_by(username: params[:username])

    offset, limit = params[:offset] || 0, params[:limit] || 50

    if user
      @tweets = user.liked_tweets(offset, limit)
      @tweets.each do |tweet|
        if tweet.attributes['text']
         tweet.view
        end
      end
      render :index
    else
      render json: {error: 'User id not found.'}
    end
  end
  

  def like_toggle
    @tweet = Tweet.find_by(id: params[:id])
    @current_user = current_user

    if @tweet
      if @tweet.liked_by_user(@current_user)
        like = Like.find_by(tweet_id: @tweet.id, user_id: @current_user.id)
        like.destroy
        @tweet.like_count -=1
      else
        like = Like.new(tweet_id: @tweet.id, user_id: @current_user.id)
        like.save
        @tweet.like_count +=1
      end
      @tweet.save
      render :show
    else
      render json: {error: 'tweet not found.'}
    end
  end


  def retweet_toggle
    @tweet = Tweet.find_by(id: params[:id])
    @current_user = current_user

    if @tweet
      if @tweet.retweeted_by_user(@current_user)
        rt = Retweet.find_by(tweet_id: @tweet.id, user_id: @current_user.id)
        rt.destroy
        @tweet.retweet_count -=1
      else
        rt = Retweet.new(tweet_id: @tweet.id, user_id: current_user.id)
        if rt.save
          rt.update(timestamp: rt.created_at)
          @tweet.retweet_count +=1
        end
      end
      @tweet.save
      render :show
    else
      render json: {error: 'tweet not found.'}
    end
  end
  
end
