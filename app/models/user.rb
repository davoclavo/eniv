class User < ActiveRecord::Base
  extend RemoteBased
  # vine_session_id
  validates :vine_id, uniqueness: true
  has_many  :posts
  has_many  :likes
  has_many  :comments
  has_many  :reposts

  def title=(title)
    self.username = title
  end
end
