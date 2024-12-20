Rails.application.routes.draw do

  get 'search', to: 'home#search', as: 'search'
  # Página de inicio público (redirige al home controller para usuarios no autenticados)
  root to: "home#index"


  # Configuración de Devise con las rutas de registro deshabilitadas
  devise_for :users, skip: [:registrations]

  # Ruta personalizada para la página de inicio de sesión
  devise_scope :user do
    get "users/sign_in", to: "devise/sessions#new"
    post "users/sign_in", to: "devise/sessions#create"
    delete "users/sign_out", to: "devise/sessions#destroy"
  end


  # Rutas protegidas (usuarios autenticados redirigen al home por defecto)
  authenticated :user do
    root to: "home#index", as: :authenticated_root
  end

  # Rutas de recursos para otros controladores
  resources :samples
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]

end
