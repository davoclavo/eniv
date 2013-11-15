class Post < ActiveRecord::Base

  include VineHasher

  belongs_to :user
  validates :vine_id, uniqueness: true

  def reverse_video
    EnivMaker.new(self).reverse
  end

end
