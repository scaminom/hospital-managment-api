class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.integer :visit_type
      t.integer :priority_level
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps

      t.references :medical_record, null: false, foreign_key: true
    end
  end
end
