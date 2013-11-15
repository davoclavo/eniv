class RemotePost
  include Her::Model
  collection_path "timelines/posts"

  def add
    user = User.find_or_initialize_by_vine_id(self.userId)
    user.update_attributes({
      username:          self.username,
      private:           self.private,
      explicit_content:  self.explicitContent,
      verified:          self.verified,
      location:          self.location,
      avatar_url:        self.avatarUrl
    })

    # self.myRepostId
    # self.postFlags
    # self.comments
    # self.likes

    post = Post.find_or_initialize_by_vine_id(self.postId)
    post.update_attributes({
      user:                 user,
      description:          self.description,
      hashed_id:            VineHasher.hash_id(self.postId),
      video_url:            self.videoUrl,
      video_low_url:        self.videoLowURL,
      thumbnail_url:        self.thumbnailUrl,
      share_url:            self.shareUrl,
      vine_created_at:      DateTime.parse(self.created),
      foursquare_venue_id:  self.foursquareVenueId,
      verified:             self.verified,
      post_flags:           self.postFlags,
      repost_count:         self.reposts['count'],
      like_count:           self.likes['count'],
      post_to_facebook:     self.postToFacebook,
      post_to_twitter:      self.postToTwitter
    })
    post
  end
end
