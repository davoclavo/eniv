class Post < ActiveRecord::Base
  belongs_to :user
  validates :vine_id, uniqueness: true
end
