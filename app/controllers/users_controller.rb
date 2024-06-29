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

  def current_user_info
    @user = current_user
    render :show
  end


  def show
    @user = User.find_by(username: params[:username])
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
  
end
