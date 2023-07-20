class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_and_belongs_to_many :publications
  has_many_attached :images # Alterado para funcionar junto con activestorage, como en el modelo de publication
  # has_many :images, as: :imageable # Previo

  # accepts_nested_attributes_for :images # Previo, se usa en caso de que acepte varias imágenes

  enum :role, [:normal_user, :admin]
end
