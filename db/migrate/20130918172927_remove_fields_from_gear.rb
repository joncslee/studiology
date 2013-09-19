class RemoveFieldsFromGear < ActiveRecord::Migration
  def change
    remove_column :gear, :url_product
    remove_column :gear, :url_image_small
    remove_column :gear, :url_image_large
    remove_column :gear, :price_high
    remove_column :gear, :price_list
    remove_column :gear, :category
    remove_column :gear, :shipping_cost
    remove_column :gear, :price_non_new
    remove_column :gear, :product_type
    remove_column :gear, :popular
    remove_column :gear, :num_raters
    remove_column :gear, :sample_review
  end
end
