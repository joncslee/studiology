class Gear < ActiveRecord::Base
  acts_as_commentable
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :ownerships, :dependent => :destroy
  has_many :studio, :through => :ownerships

  before_save :set_categories

  searchable do
    text :name, :as => :name_textp
  end

  def is_owned?(user)
    user.studio.gear.include?(self)
  end

  def url
    "/gear/#{self.slug}"
  end

  def more_popular
    Gear.joins(:ownerships).
      select('gear.*, count(gear_id) as "gear_count"').
      where('gear.category = ?', self.category).
      having('gear_count >= ?', self.ownerships.count).
      group(:gear_id).
      order('gear_count, gear.id desc').
      limit(3)
  end

  def less_popular
    Gear.joins(:ownerships).
      select('gear.*, count(gear_id) as "gear_count"').
      where('gear.category = ?', self.category).
      having('gear_count < ?', self.ownerships.count).
      group(:gear_id).
      order('gear_count, gear.id desc').
      limit(3)
  end

  def self.popular_by_category(cat)
    joins('inner join ownerships on ownerships.gear_id = gear.id').
    select('gear.*, count(ownerships.id) as ownerships_count').
    where('gear.category' => cat).
    group('gear.id').
    order('ownerships_count desc').
    limit(5)
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

  require 'csv'

  def self.parse_data_from_mf
    CSV.foreach("mfdata/Musician_s_Friend-Musicians_Friend_Product_Catalog.txt", headers: true) do |row|
      fields = row.to_hash

      name = fields['NAME']
      advertiser_category = fields['ADVERTISERCATEGORY']
      sku = fields['SKU']

      unless exclude?(name, advertiser_category)
        gear = Gear.find_by_sku(sku)
        if gear.blank?
          gear = Gear.new
        end
        gear.name = name
        gear.keywords = fields['KEYWORDS']
        gear.description = fields['DESCRIPTION']
        gear.sku = sku
        gear.manufacturer = fields['MANUFACTURER']
        gear.manufacturer_id = fields['MANUFACTURERID']
        gear.upc = fields['UPC']
        gear.sale_price = fields['SALEPRICE']
        gear.price = fields['PRICE']
        gear.retail_price = fields['RETAILPRICE']
        gear.buy_url = fields['BUYURL']
        gear.impression_url = fields['IMPRESSIONURL']
        gear.image_url = fields['IMAGEURL']
        gear.advertiser_category = advertiser_category
        gear.promotional_text = fields['PROMOTIONALTEXT']
        gear.in_stock = fields['INSTOCK']
        gear.condition = fields['CONDITION']
        gear.standard_shipping_cost = fields['STANDARDSHIPPINGCOST']
        gear.save
      end
    end
  end

  def self.find_max_categories
    max = 0
    cat = nil
    Gear.all.each_with_index do |g, i|
      puts g.id if i % 100 == 0
      cats = g.advertiser_category.split '/'
      if cats.size > max
        max = cats.size
        cat = g.advertiser_category
      end
    end
    puts "Max Cats: #{max}"
    puts cat
  end
  
  # helper method to filter out unwanted gear
  def self.exclude?(name, advertiser_category)

    if name =~ /^Used/
      true
    elsif advertiser_category =~ /^Accessories\/(Care|Strings)/
      true
    elsif advertiser_category =~ /^Brass Instruments\/Accessories for Brass Instruments\/Brass (Care|Replacement|Tools)/
      true
    elsif advertiser_category =~ /^Orchestral Strings\/Accessories for Orchestral Strings\/(Care|Replacement|Strings)/
      true
    elsif advertiser_category =~ /^Woodwinds\/Woodwind Accessories\/(Care|Woodwind Repair)/
      true
    elsif advertiser_category =~ /^(Books|Lifestyle)/
      true
    else
      false
    end
  end

  private

  def set_categories
    cat = self.advertiser_category
    if cat =~ /^Pro Audio\/iOS Devices\/iOS Microphones/ || cat =~ /^Pro Audio\/Microphones/
      self.category = 'Microphones'
    elsif cat =~ /^Pro Audio\/Recording Gear\/Audio Interfaces/
      self.category = 'Audio Interfaces'
    elsif cat =~ /^Pro Audio\/Recording Gear\/Studio Monitors/ || cat =~ /^Pro Audio\/Live Sound/ || cat =~ /^Pro Audio\/Recording Gear\/Studio Subwoofers/ || cat =~ /^Pro Audio\/Recording Gear\/Studio Power Amplifiers/
      self.category = 'Monitors/Speakers'
    elsif cat =~ /^Pro Audio\/Headphones/
      self.category = 'Headphones'
    elsif cat =~ /^Pro Audio\/Mixers/
      self.category = 'Mixers'
    elsif cat =~ /^Keyboards & MIDI/
      self.category = 'Keyboards/MIDI'
    elsif cat =~ /^Pro Audio\/Music Software/
      self.category = 'Software'
    elsif cat =~ /^Guitars/
      self.category = 'Guitars'
    elsif cat =~ /^Bass/
      self.category = 'Bass'
    elsif cat =~ /^Concert Percussion/ || cat =~ /^Drums & Percussion/ || cat =~ /^Marching Band\/Marching Percussion/
      self.category = 'Drums/Percussion'
    elsif cat =~ /^Amplifiers & Effects\/Amplifiers/
      self.category = 'Amplifiers'
    elsif cat =~ /^Amplifiers & Effects\/Effects/
      self.category = 'Effects Pedals'
    elsif cat =~ /^Pro Audio\/Signal Processors/
      self.category = 'Signal Processors'
    elsif (cat =~ /^Woodwinds/ && cat !~ /^Woodwinds\/Woodwind Acc/) || cat =~ /^Folk & Traditional Instruments/ || (cat =~ /^Brass Instruments/ && cat !~ /^Brass Instruments\/Acc/) || cat =~ /^Classroom & Kids\/Classroom Musical Instruments/ || (cat =~ /^Orchestral Strings/ && cat !~ /^Orchestral Strings\/Acc/)
      self.category = 'Instruments'
    elsif cat =~ /^Pro Audio\/Computers & Peripherals/
      self.category = 'Computers'
    elsif cat =~ /^Pro Audio\/DJ Gear/
      self.category = 'DJ'
    else
      self.category = 'Miscellaneous'
    end
  end


end
