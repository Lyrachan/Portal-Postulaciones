# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


user = User.create(email: "jefe@jefe.com", password: "123456", name: "Jefe", role: 1)
user.image.attach(io: URI.open(https://pruebam6-jorge-lira.s3.us-west-1.amazonaws.com/Da+Phuc.jpg), filename: 'Da Phuc.jpg')