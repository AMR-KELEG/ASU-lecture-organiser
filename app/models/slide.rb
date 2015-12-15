class Slide < ActiveRecord::Base
  extend FriendlyId
  friendly_id :page_number

  belongs_to :lecture
  has_many :comments, dependent: :destroy

  def next
    self.lecture.slides.find_by(page_number: page_number + 1)
  end

  def previous
    self.lecture.slides.find_by(page_number: page_number - 1)
  end
end
