class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets, { id: false } do |t|
      t.primary_key :id
      t.date :date
      t.references :account, index: true
      t.references :service, index: true
      t.text :materialslist
      t.decimal :materialscost, scale: 2
      t.decimal :labor, scale: 2
      t.decimal :total, scale: 2
      t.boolean :closed
      t.text :worklog

      t.timestamps null: false
    end
    add_foreign_key :tickets, :accounts
    add_foreign_key :tickets, :services
  end
end
