class CreateLaboratoryResults < ActiveRecord::Migration[7.1]
  def change
    create_table :laboratory_results do |t|
      t.string :test_type
      t.string :test_name
      t.text :test_result
      t.datetime :performed_at

      t.timestamps
      t.references :record, index: true, foreign_key: { to_table: :medical_records }, null: false
    end
  end
end
