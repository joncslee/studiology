class AddStudioIdToGear < ActiveRecord::Migration
  def change
    add_column :gear, :studio_id, :integer
  end
end
