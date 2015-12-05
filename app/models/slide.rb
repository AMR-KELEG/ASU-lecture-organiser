class Slide < ActiveRecord::Base
  belongs_to :lecture

  def next
    self.class.unscoped.find_by(page_number: page_number + 1)
  end

  def previous
    self.class.unscoped.find_by(page_number: page_number - 1)
  end
end
