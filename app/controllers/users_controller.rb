class UsersController < ApplicationController
  before_action :authenticate_user, only: [:current_user_info]

  def create
    user = User.new(
      name: params[:name],
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

end
