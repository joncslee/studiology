class AddSlugToGear < ActiveRecord::Migration
  def change
    add_column :gear, :slug, :string
    add_index :gear, :slug, unique: true
  end
end
