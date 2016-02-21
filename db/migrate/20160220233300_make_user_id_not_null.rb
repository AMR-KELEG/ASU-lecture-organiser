class MakeUserIdNotNull < ActiveRecord::Migration
  def change
  	change_column_null :lectures, :user_id, false
  end
end
