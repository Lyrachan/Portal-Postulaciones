# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#Esta sección se me hubiera hecho muuuuuuuy complicada de descubrir si no fuera por San-Google y San-GPT

# Es necesario cargar las gemas 

require 'open-uri'
require 'aws-sdk-s3'

# Se descarga la imagen desde S3 para usarla en la memoria del servidor del proyecto
# Para lograr descargar la imagen, se crea un cliente en la memoria temporal para poder
# tener acceso al archivo del bucket, y luego registrarlos en la base de datos con el seed
# Definí los valores con variables de entorno para fomentar la buena práctica en el código
s3_client = Aws::S3::Client.new(region: ENV['region'])
bucket_name = ENV['bucket']
object_key = 'help.png'
object_key2 = 'Da Phuc.jpg'
image_file = s3_client.get_object(bucket: bucket_name, key: object_key).body
image_file2 = s3_client.get_object(bucket: bucket_name, key: object_key2).body

user1 = User.create(email: "esteban@jefe.com", password: "123456", name: "Esteban", role: 1)
user1.images.attach(io: image_file, filename: 'help.png')

user2 = User.create(email: "user1@user.com", password: "123456", name: "Da Phuc")
user2.images.attach(io: image_file2, filename: 'Da Phuc.jpg')