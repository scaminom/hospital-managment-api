class AddNotesToMedicalRecords < ActiveRecord::Migration[7.1]
  def change
    add_column :medical_records, :notes, :text
  end
end
