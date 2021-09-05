class AuthsController < ApplicationController

  include BCrypt

  def signin
    username = params[:username]
    password = params[:password]

    if check_user_exists(username)
      user = User.find_by(username: username)
      if BCrypt::Password.new(user.password).is_password? password
        render json: { token: generate_access_token({ "username": username }) }
      else
        render json: { Unauthorized: "Acesso não autorizado." }
      end
    else
      render json: { Unauthorized: "Acesso não autorizado." }
    end
  end

  def signup
    username = params[:username]
    password = params[:password]

    if not check_user_exists(username)
      BCrypt::Engine.cost = 6
      
      user = User.new
      user.username = username
      user.password = BCrypt::Password.create(password)
      user.save

      render json: { "success": "Usuário criado com sucesso." }
    else
      render json: { "Fail": "Usuário já existe." }
    end
  end

  private
    def check_user_exists(username)
      begin
        User.find_by(username: username) 
        return true
      rescue
        return false
      end
    end

    def generate_access_token(payload={})
      hmac_secret = "In0va_M1nd!"
      return JWT.encode payload, hmac_secret, "HS256"
    end
end
