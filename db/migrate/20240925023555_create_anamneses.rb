class CreateAnamneses < ActiveRecord::Migration[7.1]
  def change
    create_table :anamneses do |t|
      t.string :current_residence, null: false
      t.string :education_level, null: false
      t.string :occupation, null: false
      t.string :marital_status, null: false
      t.string :religion, null: false
      t.string :handedness, null: false
      t.string :family_reference, null: false
      t.string :gender_identity
      t.text   :medical_history
      t.timestamps

      t.references :medical_record, null: false, foreign_key: true
    end
  end
end
