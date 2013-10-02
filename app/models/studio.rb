class Studio < ActiveRecord::Base
  acts_as_commentable
  belongs_to :user
  has_many :ownerships, :dependent => :destroy
  has_many :gear, :through => :ownerships, :order => 'ownerships.created_at DESC'

  def add_gear(gear_id)
    self.ownerships.create :gear_id => gear_id
  end

  def delete_gear(gear_id)
    gear = self.ownerships.find_by_gear_id(gear_id)
    gear.destroy
  end

  def name
    "#{user.username}'s studio"
  end

  def url
    "/#{user.username}"
  end
end
