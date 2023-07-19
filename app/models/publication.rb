class Publication < ApplicationRecord
    has_and_belongs_to_many :users
    has_many :images, as: :imageable

    accepts_nested_attributes_for :images
end
