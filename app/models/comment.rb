class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :dojo, counter_cache: true

  after_save :update_last_replied_at_to_dojo
  validates_presence_of :content

  def update_last_replied_at_to_dojo
      self.dojo.update(last_replied_at: self.updated_at)
  end

end
