class User < ActiveRecord::Base
  # vine_session_id
  validates :vine_id, uniqueness: true
  has_many :posts
end
