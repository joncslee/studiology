class Studio < ActiveRecord::Base
  belongs_to :user
  has_many :ownerships
  has_many :gear, :through => :ownerships

  def add_gear(gear_id)
    self.ownerships.create :gear_id => gear_id
  end
end
