class Tag < ActiveRecord::Base
  def title=(title)
    self.name = title
  end
end
