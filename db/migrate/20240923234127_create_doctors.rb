class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :speciality, null: false
      t.string :license_number, null: false
      t.references :user, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
    end
  end
end
