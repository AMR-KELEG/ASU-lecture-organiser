class Comment < ActiveRecord::Base
  validates :text, presence: true
  belongs_to :slide
end
