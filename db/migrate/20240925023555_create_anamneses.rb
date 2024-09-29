class CreateAnamneses < ActiveRecord::Migration[7.1]
  def change
    create_table :anamneses do |t|
      t.string :gender, null: false
      t.integer :age, null: false
      t.string :birth_place, null: false
      t.string :current_residence, null: false
      t.string :education_level, null: false
      t.string :occupation, null: false
      t.string :marital_status, null: false
      t.string :blood_type, null: false
      t.string :religion, null: false
      t.string :handedness, null: false
      t.string :family_reference, null: false
      t.timestamps

      t.references :visit, null: false, foreign_key: true
    end
  end
end
