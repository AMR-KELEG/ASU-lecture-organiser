class Comment < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
