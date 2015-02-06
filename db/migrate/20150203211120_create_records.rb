class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records, { id: false } do |t|
      t.primary_key :id
      t.date :date
      t.references :account, index: true
      t.references :ticket, index: true
      t.text :notes
      t.boolean :settled
      t.decimal :income
      t.decimal :expense
      t.decimal :total

      t.timestamps null: false
    end
    add_foreign_key :records, :accounts
    add_foreign_key :records, :tickets
  end
end
