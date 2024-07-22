class UsersController < ApplicationController
  before_action :authenticate_user, only: [:current_user_info]

  def create
    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      display_name: params[:display_name],
      bio: params[:bio], 
      avi: params[:avi], 
      banner: params[:banner]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @user = current_user

    @user.update(bio: params[:bio] || @user.bio, 
    avi: params[:avi] || @user.avi, 
    banner: params[:banner] || @user.banner, 
    display_name: params[:display_name] || @user.display_name,
    verified: params[:verified] || @user.verified)

    render :show
  end

  def current_user_info
    @user = current_user
    render :show
  end


  def show
    @user = User.find_by(username: params[:username])
    @current = current_user
    render :show
  end

  def exists
    exists = false
    username, email = params[:username] || "", params[:email] || ""

    if username
      if email
        @user = User.where("LOWER( email ) = ?", email.downcase).or(User.where("LOWER( username ) = ?", username.downcase)).first
      else
        @user = User.where("LOWER( username ) = ?", username.downcase).first
      end
    else
      @user = User.where("LOWER( email ) = ?", email.downcase).first
    end
    if @user
      exists = true
    end

    render json: {user_exists: exists}
  end
  

  def follow_toggle
    @user = User.find_by(username: params[:username])
    @current = current_user

    if @user and @current
      follow = Follow.find_by(follower_id: @current.id, followed_id: @user.id)
      if follow
        follow.destroy
      else
        follow = Follow.new(follower_id: @current.id, followed_id: @user.id)
        follow.save
      end
      render :show
    else 
      render json: {error: 'user not found'}
    end

  end


  def who_to_follow
    @current = current_user
    @users = @current.who_to_follow

    render :index
  end

end
