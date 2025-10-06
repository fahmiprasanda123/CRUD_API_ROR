# db/migrate/xxxxxxxxxxxxxx_create_products.rb
class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price

      t.timestamps # Ini akan membuat kolom created_at dan updated_at secara otomatis
    end
  end
end