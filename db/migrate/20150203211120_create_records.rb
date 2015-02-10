class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records, { id: false } do |t|
      t.primary_key :id
      t.date :date
      t.references :account, index: true
      t.references :ticket, index: true
      t.text :notes
      t.boolean :settled
      t.decimal :income, scale: 2
      t.decimal :expense, scale: 2
      t.decimal :total, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :records, :accounts
    add_foreign_key :records, :tickets
  end
end
