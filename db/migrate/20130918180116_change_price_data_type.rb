class ChangePriceDataType < ActiveRecord::Migration
  def change
    change_column :gear, :price, :decimal, :precision => 8, :scale => 2
  end
end
