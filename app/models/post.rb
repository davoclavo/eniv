class Post < ActiveRecord::Base
  extend RemoteBased

  belongs_to :user
  has_many   :likes
  has_many   :comments
  has_many   :reposts
  has_many   :entities
  validates  :vine_id, uniqueness: true

  def reverse_video
    EnivMaker.new(self).reverse
  end

end
