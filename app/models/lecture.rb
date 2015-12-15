class Lecture < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  mount_uploader :attachment, LectureUploader
  validates :name, presence: true
  has_many :slides
end
