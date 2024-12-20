class Tenant < ApplicationRecord
    has_many :users
    has_many :samples, dependent: :destroy
  
    # Define el tenant actual en un almacenamiento seguro por hilo
    def self.current=(tenant)
      Thread.current[:current_tenant] = tenant
    end
  
    def self.current
      Thread.current[:current_tenant]
    end
end
  