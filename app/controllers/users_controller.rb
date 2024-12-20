class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_role, only: [:index, :new, :create, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update]
  before_action :set_locale

  def index
    @users = User.where(tenant: Tenant.current) # Muestra solo usuarios del tenant actual
  end

  def new
    @user = User.new
  end

  def create
    # Generar una contraseña si no se proporciona
    generated_password = params[:user][:password].presence || SecureRandom.hex(8)

    # Asignar el tenant actual al usuario
    @user = User.new(user_params.merge(
      password: generated_password,
      password_confirmation: generated_password,
      tenant: Tenant.current
    ))

    if @user.save
      send_user_created_email(@user, generated_password)
      flash[:notice] = 'Usuario creado correctamente. Se ha enviado un correo al usuario.'
      redirect_to users_path
    else
      flash.now[:alert] = 'Hubo un error al crear el usuario. Verifique los campos marcados.'
      Rails.logger.debug("Errores al crear usuario: #{@user.errors.full_messages}")
      render :new
    end
  end

  def edit; end

  def update
    Rails.logger.debug "Parámetros recibidos para actualización: #{params[:user].inspect}"
  
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  
    if @user.update(user_params)
      send_user_updated_email(@user)
      flash[:notice] = 'Usuario actualizado correctamente.'
      redirect_to users_path
    else
      flash.now[:alert] = 'Hubo un error al actualizar el usuario. Verifique los campos marcados.'
      Rails.logger.debug "Errores al actualizar usuario: #{@user.errors.full_messages}"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'Usuario eliminado con éxito.'
    else
      flash[:alert] = 'Hubo un error al intentar eliminar el usuario.'
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_user
    @user = User.where(tenant: Tenant.current).find_by(id: params[:id])
    redirect_to users_path, alert: 'Usuario no encontrado.' unless @user
  end

  def authorize_role
    redirect_to root_path, alert: 'Acceso no autorizado.' unless current_user.admin?
  end

  def authorize_user
    redirect_to root_path, alert: 'No autorizado.' unless current_user == @user || current_user.admin?
  end

  def send_user_created_email(user, password)
    UserMailer.user_created(user, password).deliver_now
  rescue StandardError => e
    Rails.logger.error("Error al enviar correo de creación: #{e.message}")
    flash[:alert] = 'Usuario creado, pero hubo un error al enviar el correo de bienvenida.'
  end

  def send_user_updated_email(user)
    UserMailer.user_updated(user).deliver_now
  rescue StandardError => e
    Rails.logger.error("Error al enviar correo de actualización: #{e.message}")
    flash[:alert] = 'Usuario actualizado, pero hubo un error al enviar el correo.'
  end
end
