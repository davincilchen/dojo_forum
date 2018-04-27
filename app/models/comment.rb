class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dojo, counter_cache: true
end
