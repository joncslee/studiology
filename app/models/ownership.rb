class Ownership < ActiveRecord::Base
  belongs_to :studio
  belongs_to :gear
end
