class PublicationsUser < ApplicationRecord
    belongs_to :user
    belongs_to :publication
end

# Creé una tabla intermedia con has_and_belongs_to_many, pero debí usar una tabla intermedia sin eso ):, así que me dio unos pasos más
# Por como está planteada esta tabla intermedia, para acceder a los registros con un valor específico, 
# se anotaría en consola como: PublicationsUser.where(publication_id: publication_id) --> Para buscar las postulaciones de una publicación
# Para buscar las postulaciones de un usuario sería como: PublicationsUser.where(user_id: user_id)
# PublicationsUser.where(publication_id: 1).all.first.user.name se puede usar para acceder al nombre de un usuario de la tabla intermedia
# publications_users_with_specific_user_id.each do |publications_user| es una de las maneras para acceder a todas las publicaciones de un usuario
# (según lo que pude encontrar investigando)