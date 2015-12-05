class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :path
      t.integer :lecture_id

      t.timestamps null: false
    end
  end
end
