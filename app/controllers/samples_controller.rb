class SamplesController < ApplicationController
  before_action :authenticate_user! # Requiere inicio de sesión
  before_action :ensure_not_admin, except: [:index, :show] # Bloquea acceso a administradores excepto para index y show
  before_action :set_sample, only: [:edit, :update, :destroy] # Carga la muestra antes de ciertas acciones
  before_action :authorize_sample_access, only: [:edit, :update, :destroy] # Verifica permisos de acceso

  # Lista de muestras según el tenant y rol del usuario
  def index
    @samples = Sample.for_current_tenant # Aplica el filtro multitenant
  end

  # Mostrar una muestra específica
  def show
    @sample = Sample.for_current_tenant.find(params[:id]) # Filtro multitenant
  rescue ActiveRecord::RecordNotFound
    redirect_to samples_path, alert: 'La muestra solicitada no existe.'
  end

  # Formulario para nueva muestra
  def new
    @sample = Sample.new
  end

  # Crear una nueva muestra
  def create
    @sample = Sample.new(sample_params)
    @sample.tenant = Tenant.current # Asocia la muestra al tenant actual

    if @sample.save
      redirect_to samples_path, notice: 'Muestra creada correctamente.'
    else
      flash.now[:alert] = 'Hubo un error al crear la muestra. Revisa los campos.'
      render :new
    end
  end

  # Formulario para editar una muestra
  def edit
  end

  # Actualizar una muestra existente
  def update
    if @sample.update(sample_params)
      redirect_to samples_path, notice: 'Muestra actualizada correctamente.'
    else
      flash.now[:alert] = 'Hubo un error al actualizar la muestra.'
      render :edit
    end
  end

  # Eliminar una muestra
  def destroy
    @sample.destroy
    redirect_to samples_path, notice: 'Muestra eliminada correctamente.'
  end

  private

  # Configura la muestra según ID y tenant actual
  def set_sample
    @sample = Sample.for_current_tenant.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to samples_path, alert: 'La muestra solicitada no existe.'
  end

  # Bloquea acceso a administradores para ciertas acciones
  def ensure_not_admin
    redirect_to users_path, alert: 'Los administradores no tienen acceso a esta acción.' if current_user.admin?
  end

  # Verifica si el usuario tiene acceso a la muestra
  def authorize_sample_access
    unless can_access_sample?(@sample)
      redirect_to samples_path, alert: 'No tienes permiso para acceder a esta muestra.'
    end
  end

  # Define si el usuario puede acceder a la muestra
  def can_access_sample?(sample)
    if current_user.laboratorista?
      sample.laboratorista == current_user
    elsif current_user.cliente?
      sample.user == current_user
    else
      false
    end
  end

  # Define los parámetros permitidos
  def sample_params
    params.require(:sample).permit(:code, :results, :user_id)
  end
end
