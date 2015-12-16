class Slide < ActiveRecord::Base
  extend FriendlyId
  friendly_id :page_number, use: [:finders]

  belongs_to :lecture
  has_many :comments, dependent: :destroy

  def next
    slide = lecture.slides.find_by(page_number: (page_number + 1 - 1) % lecture.slides.count + 1)
  end

  def previous
    slide = lecture.slides.find_by(page_number: (page_number - 1 - 1) % lecture.slides.count + 1)
  end
end
