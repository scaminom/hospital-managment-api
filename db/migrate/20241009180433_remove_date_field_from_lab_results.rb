class RemoveDateFieldFromLabResults < ActiveRecord::Migration[7.1]
  def change
    remove_column :laboratory_results, :performed_at
    add_column :laboratory_results, :status, :integer, null: false, default: 0
  end
end
