class FixDojoColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :dojos, :replies_count, :comments_count
  end
end
