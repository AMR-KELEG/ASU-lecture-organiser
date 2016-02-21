class AddUserToLecture < ActiveRecord::Migration
  def change
  	add_belongs_to(:lectures,:user)
  end
end
