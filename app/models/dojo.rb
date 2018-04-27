class Dojo < ApplicationRecord
  mount_uploader :image, PhotoUploader
  validates_presence_of :title


  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user

  has_many :dojo_categories
  has_many :categories, through: :dojo_categories

  has_many :vieweds, dependent: :destroy
  has_many :viewed_users, through: :vieweds, source: :user

  def is_collected?(user)
    self.collected_users.include?(user)
  end

  def is_viewed?(user)
    self.viewed_users.include?(user)
  end

  def viewed_dojo
    self.viewed_count+=1;
    self.save
  end

end
