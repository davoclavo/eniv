class User < ActiveRecord::Base
  # validates :vine_id, uniqueness: true
  has_many :posts
end
