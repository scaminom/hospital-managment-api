class UpdateVisitsForAppointments < ActiveRecord::Migration[7.1]
  def change
    add_reference :visits, :appointment, foreign_key: true
    remove_column :visits, :date, :datetime
  end
end
