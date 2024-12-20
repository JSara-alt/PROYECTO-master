class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      # Si el usuario ya está autenticado, mostrar contenido del Home
      @samples = Sample.all.limit(5)
    else
      # Si no está autenticado, redirigir al login
      redirect_to new_user_session_path
    end
  end
end
