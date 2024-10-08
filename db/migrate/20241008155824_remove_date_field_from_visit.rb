class RemoveDateFieldFromVisit < ActiveRecord::Migration[7.1]
  def change
    remove_column :visits, :date
  end
end
