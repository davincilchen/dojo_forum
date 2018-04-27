class AddLastReplyToDojo < ActiveRecord::Migration[5.1]
  def change
    add_column :dojos, :last_replied_at, :datetime
  end
end
