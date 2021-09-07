class ApplicationController < ActionController::API
  # Retorna um json com a mensagem de acesso não autorizado. 
  def unauthorized(message = "Acesso não autorizado.")
    render json: { status_code: 401, message: message }, status: :unauthorized
  end

  # Retorna um json com a mensagem de requisição mal formada.
  def badrequest(message = "Requisição mal formada.")
    render json: { status_code: 400, message: message }, status: :bad_request
  end

  # Retorna um json com a mensagem de que não foi encontrado.
  def notfound(message = "Não foi encontrado.")
    render json: { status_code: 404, message: message }, status: :not_found
  end
end
