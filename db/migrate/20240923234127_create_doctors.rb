class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :speciality, null: false
      t.string :license_number, null: false
      t.references :user, null: false, foreign_key: true
      t.references :department, foreign_key: true
    end

    add_index :doctors, :license_number, unique: true
  end
end
