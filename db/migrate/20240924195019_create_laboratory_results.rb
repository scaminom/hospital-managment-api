class CreateLaboratoryResults < ActiveRecord::Migration[7.1]
  def change
    create_table :laboratory_results do |t|
      t.string :test_type, null: false
      t.string :test_name, null: false
      t.text :test_result, null: false
      t.datetime :performed_at, null: false

      t.timestamps
      t.references :record, index: true, foreign_key: { to_table: :medical_records }, null: false
    end
  end
end
