class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.integer :visit_type, null: false
      t.integer :priority_level, null: false
      t.datetime :date, null: false

      t.timestamps

      t.references :medical_record, null: false, foreign_key: true
    end
  end
end
