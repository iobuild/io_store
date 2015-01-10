# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  u = User.new(
      email: "admin@example.com",
      username: 'Iamadmin',
      password: "11111111",
      password_confirmation: "11111111",
      admin: true
  )
  u.save!




Product.create(
  title: 'tea1',
  desc: 'desc',
  price: 3.0
)

Product.create(
  title: 'tea2',
  desc: 'desc',
  price: 3.0
)