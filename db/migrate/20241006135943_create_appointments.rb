class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.datetime :scheduled_time, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end

    add_index :appointments, [:doctor_id, :scheduled_time]
  end
end
