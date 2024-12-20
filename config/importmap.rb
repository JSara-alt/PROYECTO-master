# Pin npm packages by running ./bin/importmap

# Pin principal de la aplicación
pin "application"

# Turbo y Stimulus (Hotwire)
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

# Controladores de Stimulus
pin_all_from "app/javascript/controllers", under: "controllers"

# Rails UJS para manejar funcionalidades de Rails como métodos remotos
pin "@rails/ujs", to: "@rails--ujs.js" # Asegura una sola línea para @rails/ujs
