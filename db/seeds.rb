# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)



User.create_or_find_by!(email: 'mark20@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
User.create_or_find_by!(email: 'mark30@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')
User.create_or_find_by!(email: 'mark40@gmail.com', password: 'aaaaaa', password_confirmation: 'aaaaaa')

