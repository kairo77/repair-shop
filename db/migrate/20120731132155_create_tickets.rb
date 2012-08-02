class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :customer_id
      t.boolean :closed
      t.string :manufacturer
      t.string :model
      t.string :serial_number
      t.text :problem
      t.text :solution
      t.text :notes

      t.timestamps
    end
  end
end
