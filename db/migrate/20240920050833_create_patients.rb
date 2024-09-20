class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :insurance_number
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.string :gender
      t.string :address
      t.string :phone_number
      t.string :email
      t.string :blood_type
      t.text :allergies

      t.timestamps
    end

    add_index :patients, :insurance_number, unique: true
    add_index :patients, :email, unique: true
  end
end
