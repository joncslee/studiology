class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  has_one :studio, :dependent => :destroy

  after_create :create_studio

  private

end
