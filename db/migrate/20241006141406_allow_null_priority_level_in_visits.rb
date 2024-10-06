class AllowNullPriorityLevelInVisits < ActiveRecord::Migration[7.1]
  def change
    change_column_null :visits, :priority_level, true
  end
end
