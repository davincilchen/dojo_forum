# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




# Category
Category.destroy_all

category_list = [
  { name: "Sport" },
  { name: "Art" },
  { name: "Food" },
  { name: "Book" },
  { name: "Economic" },
  { name: "Mood" },
  { name: "Travel" }
]


category_list.each do |category|
  Category.create( name: category[:name])
end
puts "create category (seeds)"



#Default admin
User.create(email: "admin@example.com", password: "12345678", role: "admin", name: "Admin")
puts "Default admin created!"