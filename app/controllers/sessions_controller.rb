class SessionsController < ApplicationController
  def login
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      token = encode_token(user.id)
      render json: { user: user, token: token, message: "Login Successful!" }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    # head :no_content
    render json: { message: "Logout is successful!" }

  end

  private

  def encode_token(user_id)
    payload = { user_id: user_id }
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secret_key_base)[0]
  rescue JWT::DecodeError
    nil
  end

  def authenticate_user
    token = request.headers["Authorization"]&.split(" ")&.last
    decoded_token = decode_token(token)

    if decoded_token && user_id = decoded_token["user_id"]
      @current_user = User.find_by(id: user_id)
    else
      render json: { error: "Invalid token" }, status: :unauthorized
    end
  end
end