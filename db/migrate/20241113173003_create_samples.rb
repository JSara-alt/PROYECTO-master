class CreateSamples < ActiveRecord::Migration[6.1]
  def change
    create_table :samples do |t|
      t.string :code, null: false
      t.text :results, null: false
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :laboratorista, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :samples, :code, unique: true
  end
end
