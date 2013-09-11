class AddFieldsToGear < ActiveRecord::Migration
  def change
    add_column :gear, :description, :text
    add_column :gear, :sku, :string
    add_column :gear, :url_product, :string
    add_column :gear, :url_image_small, :string
    add_column :gear, :url_image_large, :string
    add_column :gear, :price, :decimal
    add_column :gear, :price_high, :decimal
    add_column :gear, :price_list, :decimal
    add_column :gear, :category, :string
    add_column :gear, :manufacturer, :string
    add_column :gear, :shipping_cost, :decimal
    add_column :gear, :price_non_new, :decimal
    add_column :gear, :product_type, :string
    add_column :gear, :popular, :integer
    add_column :gear, :num_raters, :integer
    add_column :gear, :sample_review, :text
  end
end
