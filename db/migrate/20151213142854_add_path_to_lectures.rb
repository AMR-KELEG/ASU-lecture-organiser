class AddPathToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :path, :string
  end
end
