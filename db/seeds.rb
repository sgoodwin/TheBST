# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#

Currency.create(name: "USD", symbol: "$")
Currency.create(name: "EUR", symbol: "€")
Currency.create(name: "JPY", symbol: "¥")

Region.create(name: "United States")
Region.create(name: "Canada")
Region.create(name: "Europe")
Region.create(name: "Japan")
