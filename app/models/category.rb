class Category < ApplicationRecord
  has_many :dojo_categories, dependent: :restrict_with_error
  has_many :dojos, through: :dojo_categories
end
