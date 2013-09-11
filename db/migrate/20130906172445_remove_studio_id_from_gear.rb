class RemoveStudioIdFromGear < ActiveRecord::Migration
  def change
    remove_column :gear, :studio_id, :integer
  end
end
