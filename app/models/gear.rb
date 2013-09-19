class Gear < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :ownerships, :dependent => :destroy
  has_many :studio, :through => :ownerships

  searchable do
    text :name, :as => :name_textp
  end

  def is_owned?(user)
    user.studio.gear.include?(self)
  end

  def similar_gear
    Gear.joins(:ownerships).select('gear.*, count(gear_id) as "gear_count"').where('gear.advertiser_category = ?', self.advertiser_category).group(:gear_id).order('gear_count desc')
  end

  def self.parse_data_from_zzounds
    count = 0
    File.open("#{Rails.root}/zdata/feed--affiliate.txt", "r").each_line do |line|
      line.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)
      fields = line.split("\t")

      gear = Gear.new
      gear.name = fields[0]
      gear.description = fields[1]
      gear.sku = fields[2]
      gear.url_product = fields[3]
      gear.url_image_small = fields[4]
      gear.url_image_large = fields[5]
      gear.price = fields[6]
      gear.price_high = fields[7]
      gear.price_list = fields[8]
      gear.category = fields[9]
      gear.manufacturer = fields[10]
      gear.shipping_cost = fields[11]
      gear.price_non_new = fields[12]
      gear.product_type = fields[13]
      gear.popular = fields[14]
      gear.num_raters = fields[15]
      gear.sample_review = fields[16]
      gear.save

      count += 1
    end
    
    puts "Product Count: #{count}"

  end

  # Name
  # Description
  # SKU
  # URL_Product
  # URL_Image_Small
  # URL_Image_Large
  # Price
  # Price_High
  # Price_List
  # Category
  # Manufacturer
  # Shipping_Cost
  # Price_Non_New
  # Product_Type
  # Popular
  # Num_Raters
  # Sample_Review

  require 'csv'

  def self.parse_data_from_mf
    longest = 0
    CSV.foreach("mfdata/Musician_s_Friend-Musicians_Friend_Product_Catalog.txt", headers: true) do |row|
      fields = row.to_hash

      gear = Gear.new
      gear.name = fields['NAME']
      gear.keywords = fields['KEYWORDS']
      gear.description = fields['DESCRIPTION']
      gear.sku = fields['SKU']
      gear.manufacturer = fields['MANUFACTURER']
      gear.manufacturer_id = fields['MANUFACTURERID']
      gear.upc = fields['UPC']
      gear.sale_price = fields['SALEPRICE']
      gear.price = fields['PRICE']
      gear.retail_price = fields['RETAILPRICE']
      gear.buy_url = fields['BUYURL']
      gear.impression_url = fields['IMPRESSIONURL']
      gear.image_url = fields['IMAGEURL']
      gear.advertiser_category = fields['ADVERTISERCATEGORY']
      gear.promotional_text = fields['PROMOTIONALTEXT']
      gear.in_stock = fields['INSTOCK']
      gear.condition = fields['CONDITION']
      gear.standard_shipping_cost = fields['STANDARDSHIPPINGCOST']
      gear.save
    end
  end

end
