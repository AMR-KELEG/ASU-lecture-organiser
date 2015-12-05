class AddPageNumberToSlide < ActiveRecord::Migration
  def change
    add_column :slides, :page_number, :integer
  end
end
