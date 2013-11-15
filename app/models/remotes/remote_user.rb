class RemoteUser
  include Her::Model
  collection_path "users/profiles"

  def add
    user = User.find_or_initialize_by_vine_id(self.userId)
    user.update_attributes({
      username:             self.username,
      description:          self.description,
      private:              self.private,
      post_count:           self.postCount,
      authored_post_count:  self.authoredPostCount,
      likes_count:          self.likeCount,
      repost_count:         self.repostCount,
      follower_count:       self.followerCount,
      following_count:      self.followingCount,
      explicit_content:     self.explicitContent,
      verified:             self.verified,
      location:             self.location,
      avatar_url:           self.avatarUrl
    })
    user
  end

end
