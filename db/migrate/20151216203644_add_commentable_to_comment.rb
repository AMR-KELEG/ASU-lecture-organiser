class AddCommentableToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :commentable, index: true, polymorphic: true
    remove_column :comments, :slide_id
  end
end
