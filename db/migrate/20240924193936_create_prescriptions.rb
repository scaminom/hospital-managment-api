class CreatePrescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :prescriptions do |t|
      t.string :medication
      t.string :dosage
      t.string :duration
      t.timestamps

      t.references :record, index: true, foreign_key: { to_table: :medical_records }, null: false
    end
  end
end
