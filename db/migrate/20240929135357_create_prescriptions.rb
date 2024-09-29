class CreatePrescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :prescriptions do |t|
      t.string :medication, null: false
      t.string :dosage, null: false
      t.string :duration, null: false

      t.timestamps
      t.references :visit, null: true, foreign_key: true
    end
  end
end
