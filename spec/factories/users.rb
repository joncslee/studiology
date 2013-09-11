# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password Faker::Internet.password
  end
end
