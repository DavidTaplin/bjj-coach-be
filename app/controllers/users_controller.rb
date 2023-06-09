class UsersController < ApplicationController
  before_action :authorize_request, except: :create

  # POST /signup
  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     payload = {
  #       email: params[:email],
  #       password: params[:password],
  #     }
  #     render json: { payload: payload, message: "User created successfully" }, status: :created
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      token = encode_token(@user.id)
      render json: { user: @user, token: token, message: "User created successfully" }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end



  # GET /users/:id
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private

  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secret_key_base)
  end

  def user_params
    params.permit(:email, :password)
  end
end
