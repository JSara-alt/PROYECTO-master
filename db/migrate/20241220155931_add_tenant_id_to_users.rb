class AddTenantIdToUsers < ActiveRecord::Migration[7.0]
  def change
    # Agregar la columna tenant_id sin restricción NOT NULL inicialmente
    add_reference :users, :tenant, foreign_key: true, null: true

    # Rellenar la columna tenant_id con un tenant predeterminado
    default_tenant = Tenant.first || Tenant.create!(name: "Default Tenant", subdomain: "default")
    User.update_all(tenant_id: default_tenant.id)

    # Ahora aplica la restricción NOT NULL
    change_column_null :users, :tenant_id, false
  end
end
