class SessionsController < ApplicationController

  def create
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { user: user, token: token }

    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    head :no_content
  end

  private 

  def encode_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secret_key_base)
  end
end
