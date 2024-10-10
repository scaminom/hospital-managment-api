class CreateLaboratoryResults < ActiveRecord::Migration[7.1]
  def change
    create_table :laboratory_results do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.text :results
      t.datetime :performed_at, null: false

      t.timestamps
      t.references :visit, null: true, foreign_key: true
    end
  end
end
