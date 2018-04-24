class Dojo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :title


  belongs_to :user
  has_many :comments, dependent: :destroy

end
