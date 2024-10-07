class CreateMedicalRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :medical_records do |t|
      t.timestamps

      t.references :patient, null: false, foreign_key: true
    end
  end
end
