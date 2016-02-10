class AddSlugToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :slug, :string
    add_index :lectures, :slug
  end
end
