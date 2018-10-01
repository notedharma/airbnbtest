# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = {}
user['password'] = 'asdf'
# user['password_confirmation'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do 
    user['first_name'] = Faker::Name.first_name 
    user['last_name'] = Faker::Name.last_name
    user['email'] = Faker::Internet.email
    user['phone'] = Faker::PhoneNumber.phone_number
    user['country'] = Faker::Address.country

    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['title'] = Faker::App.name
    listing['description'] = Faker::Hipster.sentence
    listing['address'] = Faker::Address.street_address
    listing['city'] = Faker::Address.city
    listing['country'] = Faker::Address.country
    listing['user_id'] = uids.sample
    listing['property_type'] = ["Entire House", "Entire Apartment", "Private Room", "Shared Room", "Hotel Room", "Other"].sample
    listing['beds'] = rand(1..6)
    listing['max_guests'] = rand(1..10)
    listing['price_night'] = rand(80..500)



    Listing.create(listing)
  end
end