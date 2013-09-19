# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
  user = User.create :username => "#{Faker::Name.first_name}#{n}", :email => Faker::Internet.email, :password => Faker::Internet.password
  if user.present? && user.valid?
    10.times do
      user.studio.add_gear rand(Gear.count)
    end
  end
end
