# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


Course.create!(name: "Ruby on Rails", description: "Learn Ruby on Rails", price: 100)
Course.create!(name: "React", description: "Learn React", price: 200)
Course.create!(name: "Vue", description: "Learn Vue", price: 300)
Course.create!(name: "Angular", description: "Learn Angular", price: 400)
Course.create!(name: "Node", description: "Learn Node", price: 500)
Course.create!(name: "Python", description: "Learn Python", price: 600)
Course.create!(name: "Django", description: "Learn Django", price: 700)
