class AddCascadeDeleteToSamples < ActiveRecord::Migration[6.1]
  def change
    # Elimina las claves foráneas existentes
    remove_foreign_key :samples, column: :user_id
    remove_foreign_key :samples, column: :laboratorista_id

    # Agrega nuevas claves foráneas con eliminación en cascada
    add_foreign_key :samples, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :samples, :users, column: :laboratorista_id, on_delete: :cascade
  end
end
