class Dojo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :title
end
