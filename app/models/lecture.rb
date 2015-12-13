class Lecture < ActiveRecord::Base
  mount_uploader :attachment, LectureUploader
  validates :name, presence: true
  has_many :slides
end
