class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts, { id: false } do |t|
      t.primary_key :id
      t.string :category
      t.string :name
      t.string :business
      t.string :phone
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.text :notes

      t.timestamps null: false
    end
  end
end
