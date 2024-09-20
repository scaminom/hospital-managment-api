class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :insurance_number, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.datetime :date_of_birth, null: false
      t.string :gender, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.string :email, null: false
      t.string :blood_type, null: false
      t.text :allergies, null: false

      t.timestamps
    end

    add_index :patients, :insurance_number, unique: true
    add_index :patients, :email, unique: true
  end
end
