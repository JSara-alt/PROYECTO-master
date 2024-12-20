class Sample < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id' # Cliente
  belongs_to :laboratorista, class_name: 'User', foreign_key: 'laboratorista_id' # Laboratorista
  #TENANT
  belongs_to :tenant
  #PARA HACER INDEPENDIENTE EL DOMINIO
  scope :for_current_tenant, -> { where(tenant: Tenant.current) }
  validates :code, presence: true, uniqueness: true
  validates :results, presence: true
end

