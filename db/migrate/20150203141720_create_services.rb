class CreateServices < ActiveRecord::Migration
  def change
    create_table :services, { id: false } do |t|
      t.primary_key :id
      t.string :category
      t.decimal :price, scale: 2
      t.string :rate

      t.timestamps null: false
    end
  end
end
