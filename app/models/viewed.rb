class Viewed < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :dojo_id #validates :user_id, uniqueness: { scope: :dojo_id }


  belongs_to :user
  belongs_to :dojo, counter_cache: :viewed_count
end
