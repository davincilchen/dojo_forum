class CreateCollects < ActiveRecord::Migration[5.1]
  def change
    create_table :collects do |t|
      t.integer "user_id"
      t.integer "dojo_id"

      t.timestamps
    end
  end
end
