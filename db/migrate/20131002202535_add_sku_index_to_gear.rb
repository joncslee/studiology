class AddSkuIndexToGear < ActiveRecord::Migration
  def change
    add_index :gear, :sku, :unique => true
  end
end
