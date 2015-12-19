class Lecture < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]
  has_many :comments, as: :commentable, dependent: :destroy

  def slug_candidates
    [
      :name,
      [:name, generate_code(3)]
    ]
  end

  def generate_code(number)
    charset = Array('A'..'Z') + Array('a'..'z')+Array(0..9)
    charset.shuffle[0,3].join
  end

  mount_uploader :attachment, LectureUploader
  validates :name, presence: true
  has_many :slides
end
