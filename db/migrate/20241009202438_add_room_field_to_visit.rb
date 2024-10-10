class AddRoomFieldToVisit < ActiveRecord::Migration[7.1]
  def change
    add_column :visits, :room, :string, null: false
  end
end
