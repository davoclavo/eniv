class Post < ActiveRecord::Base
  belongs_to :user
  validates :vine_id, uniqueness: true

  def reverse_video
    EnivMaker.new(self).reverse
  end

  def self.fetch(id)
    rp = RemotePost.find(id)
    rp.add
  end

end
