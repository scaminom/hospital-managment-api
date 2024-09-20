class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.references :medical_record, null: false, foreign_key: true
      t.integer :visit_type, null: false, default: 0
      t.integer :priority_level, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps
    end
  end
end
