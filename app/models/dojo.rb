class Dojo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :title


  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user


  def is_collected?(user)
    self.collected_users.include?(user)
  end

end
