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

user2 = User.create(email: "user1@user.com", password: "123456", name: "Juan Muñoz Phucc", age: 23, description: "Hola.")
user2.images.attach(io: image_file2, filename: 'Da Phuc.jpg')

# Como no se simula un sitio web con una cantidad masiva de usuarios, publicaciones y comentarios,
# preferí generar los datos ficticios manualmente para que fueran más personalizados

#id 3
User.create(email: "user2@user.com", password: "123456", name: "Martín Castañeda Villarroel", age: 38, description: "Electricista con un amplio campo de experiencia, ejerciendo hace 16 años en la instalación de redes eléctricas y mantención.")

#id 4
User.create(email: "user3@user.com", password: "123456", name: "Roberto Bravo González", age: 79, description: "Bodeguero a medio tiempo, con décadas de experiencia en la composición e interpretación de piezas de piano.")
User.create(email: "user4@user.com", password: "123456", name: "Margarita Campos Manríquez", age: 51, description: "Analista de datos con 26 años de desempeño en el rubro. Actualmente especializándome en Data Science a través de un curso en línea de Harvard.")

#id 6
User.create(email: "user5@user.com", password: "123456", name: "Isabella Guerrero Sotomayor", age: 42, description: "Contadora auditora con 4 años en el cargo.")

#Publicaciones
Publication.create(name: "Fiscalización urbana", description: "Oferta enviada por empresa afiliada. Consiste en realizar patrullas rutinarias por vecindarios para amonestar a los infractores de una sociedad saludable")
Publication.create(name: "Mecánico veterinario", description: "Puesto para mecánica automotriz para los vehículos de las mascotas de la empresa. Experiencia mínima requerida de 2 años.")
Publication.create(name: "Catador de pan", description: "Debido a la necesidad del casino interno para evaluar la calidad del pan de las panaderías anexas, se ofrece un puesto con horario laboral flexible, y un pago adicional por comisión en base a la cantidad de pan probado.")
Publication.create(name: "Supervisor de asientos", description: "Trabajo Remoto")

# "Postulaciones" ---> El usuario "postula" al añadirse a la publicación en su tabla intermedia 'publicaciones_users'
PublicationsUser.create(user_id: 2, publication_id: 4)
PublicationsUser.create(user_id: 3, publication_id: 1)
PublicationsUser.create(user_id: 3, publication_id: 2)
PublicationsUser.create(user_id: 3, publication_id: 3)
PublicationsUser.create(user_id: 4, publication_id: 1)
PublicationsUser.create(user_id: 4, publication_id: 2)
PublicationsUser.create(user_id: 4, publication_id: 4)
PublicationsUser.create(user_id: 5, publication_id: 4)
PublicationsUser.create(user_id: 6, publication_id: 2)
PublicationsUser.create(user_id: 6, publication_id: 3)