class AuthsController < ApplicationController
  include BCrypt

  def signin
    username = params[:username]
    password = params[:password]

    if check_user_exists?(username)
      user = User.find_by(username: username)
      if check_password(user.password, password)
        render json: {
          username: username,
          jwt:{
            "prefix": "Bearer",
            encodedToken: generate_access_token({ 
              "username": username,
              "date_access": DateTime.now
            }),
            date_access: DateTime.now
          }
        }
      else
        unauthorized()
      end
    else
      unauthorized()
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
        unauthorized("Os campos 'username' e 'password' devem ter no mínimo 6 caracteres.")
      end
    else
      unauthorized("Usuário já existe.")
    end
  end

  def remove
    username = params[:username]
    password = params[:password]
    
    if check_user_exists?(username)
      user = User.find_by(username: username)
      if check_password(user.password, password)
        User.delete_all(username: username)
        render json: { "Success": "Usuário '#{username}' foi removido." }
      else
        unauthorized()
      end
    else
      unauthorized()
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

    def check_password(user_password, password)
      BCrypt::Password.new(user_password).is_password? password
    end

    def unauthorized(message = "Acesso não autorizado.")
      render json: { Unauthorized: message }, status: :unauthorized
    end
end
