class AuthsController < ApplicationController
  include BCrypt

  def signin
    username = params[:username]
    password = params[:password]

    if check_user_exists?(username)
      user = User.find_by(username: username)
      if BCrypt::Password.new(user.password).is_password? password
        render json: {
          username: username,
          jwt:{
            encodedToken: generate_access_token({ 
              "username": username,
              "date_access": DateTime.now
            }),
            date_access: DateTime.now
          }
        }
      else
        render json: { Unauthorized: "Acesso não autorizado." }, status: :unauthorized
      end
    else
      render json: { Unauthorized: "Acesso não autorizado." }, status: :unauthorized
    end
  end

  def signup
    username = params[:username]
    password = params[:password]

    if not check_user_exists?(username)
      if check_size(username) and check_size(password)
        BCrypt::Engine.cost = 6
        
        user = User.new
        user.username = username
        user.password = BCrypt::Password.create(password)
        user.save

        render json: { "success": "Usuário criado com sucesso." }
      else
        render json: { "Error": "Os campos 'username' e 'password' devem ter no mínimo 6 caracteres." }, status: :unauthorized
      end
    else
      render json: { "Error": "Usuário já existe." }, status: :unauthorized
    end
  end

  private
    def check_user_exists?(username)
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

    def check_size(str, min=6) 
      str.length >= min ? true : false
    end
end
