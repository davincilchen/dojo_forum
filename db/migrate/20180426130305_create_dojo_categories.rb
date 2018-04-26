class CreateDojoCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :dojo_categories do |t|
      t.integer :dojo_id
      t.integer :category_id

      t.timestamps
    end
  end
end
