class CreateInns < ActiveRecord::Migration[7.1]
  def change
    create_table :inns do |t|
      t.references :admin, null: false, foreign_key: true
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :phone
      t.string :email
      t.string :address
      t.string :neighborhood
      t.string :state
      t.string :city
      t.string :zip_code
      t.string :description
      t.string :payment_methods
      t.boolean :accepts_pets
      t.string :usage_policies
      t.time :check_in
      t.time :check_out

      t.timestamps
    end
  end
end
