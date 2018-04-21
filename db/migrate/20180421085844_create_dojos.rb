class CreateDojos < ActiveRecord::Migration[5.1]
  def change
    create_table :dojos do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :replies_count, default: 0, null: false
      t.integer :viewed_count, default: 0, null: false
      t.string :post_status, default: "draft", null: false
      t.string :authority, default: "all", null: false
      t.string :image

      t.timestamps
    end
  end
end
