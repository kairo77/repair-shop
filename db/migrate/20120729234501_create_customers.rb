class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.string :company_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :home
      t.string :work
      t.string :mobile
      t.string :fax
      t.string :email
      t.string :contact_preference

      t.timestamps
    end
  end
end
