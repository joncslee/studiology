class Gear < ActiveRecord::Base
  has_many :ownerships
  has_many :studio, :through => :ownerships

  def self.search(search)
    search_length = search.split.length
    all(:conditions => [(['name LIKE ?'] * search_length).join(' AND ')] + search.split.map { |name| "%#{name}%" }, :limit => 20)
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


end
