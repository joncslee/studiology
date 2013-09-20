class AddCategoryToGear < ActiveRecord::Migration
  def change
    add_column :gear, :category, :string
  end
end
