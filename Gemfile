source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.6"

gem "rails", "~> 7.0.0" # Framework principal
gem "sprockets-rails" # Asset pipeline para Rails
gem "pg", "~> 1.1" # Base de datos PostgreSQL
gem "puma", "~> 5.0" # Servidor web
gem "importmap-rails" # Para manejar JavaScript con ESM import maps
gem "turbo-rails" # SPA-like con Hotwire
gem "stimulus-rails" # Framework JS de Hotwire
gem "jbuilder" # Para construir JSON APIs
gem "bcrypt", "~> 3.1.7" # Para contraseñas seguras con `has_secure_password`
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby] # Para Windows
gem "bootsnap", require: false # Acelera tiempos de inicio
gem "devise", "~> 4.9" # Manejo de autenticación
gem "jquery-rails" # (Opcional) Para usar jQuery en Rails

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw] # Depuración
end

group :development do
  gem "web-console" # Consola en las páginas de error
end

group :test do
  gem "capybara" # Para pruebas de sistema
  gem "selenium-webdriver" # Driver para pruebas en navegador
  gem "webdrivers" # Automatización de drivers de navegador
end

# Opcionales: Librerías base de Ruby, si las necesitas específicamente
gem "base64", "~> 0.2.0", require: false
gem "bigdecimal", "~> 3.1", require: false
gem "mutex_m", "~> 0.2.0", require: false

gem "mailgun-ruby", "~> 1.2"
