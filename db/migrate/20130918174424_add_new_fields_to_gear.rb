class AddNewFieldsToGear < ActiveRecord::Migration
  def change
    add_column :gear, :keywords, :string
    add_column :gear, :manufacturer_id, :string
    add_column :gear, :upc, :string
    add_column :gear, :currency, :string
    add_column :gear, :sale_price, :decimal, :precision => 8, :scale => 2
    add_column :gear, :retail_price, :decimal, :precision => 8, :scale => 2
    add_column :gear, :buy_url, :string
    add_column :gear, :impression_url, :string
    add_column :gear, :image_url, :string
    add_column :gear, :advertiser_category, :string
    add_column :gear, :promotional_text, :string
    add_column :gear, :in_stock, :string
    add_column :gear, :condition, :string
    add_column :gear, :standard_shipping_cost, :decimal, :precision => 8, :scale => 2
  end
end
