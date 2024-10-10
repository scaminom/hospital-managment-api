class RenameTypeInLaboratoryResults < ActiveRecord::Migration[7.1]
  def change
    rename_column :laboratory_results, :type, :lab_type
  end
end
