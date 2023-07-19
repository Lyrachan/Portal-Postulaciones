class Publication < ApplicationRecord
    has_and_belongs_to_many :users
    # has_many :images, as: :imageable  # Previo
    has_many_attached :images   # Exclusivo de la gema activestorage, y necesario para su funcionamiento. Funciona como con el imageable

    # accepts_nested_attributes_for :images 
    # Eliminado, porque activestorage funciona aceptando atributos anidados sin necesidad de esta línea
end
