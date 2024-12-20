class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index]

  # Redirige según el rol del usuario
  def after_sign_in_path_for(resource)
    # Limpia rutas almacenadas previamente
    session[:user_return_to] = nil

    if resource.admin?
      users_path
    else
      samples_path
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path # Redirige al formulario de inicio de sesión
  end
end

  