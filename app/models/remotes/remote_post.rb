class RemotePost
  include Her::Model
  collection_path "timelines/posts"

  def add
    user = User.find_or_initialize_by(vine_id: self.userId)
    user.update_attributes(
      username:          self.username,
      private:           self.private,
      explicit_content:  self.explicitContent,
      verified:          self.verified,
      location:          self.location,
      avatar_url:        self.avatarUrl
    )

    post = Post.find_or_initialize_by(vine_id: self.postId)
    post.update_attributes(
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
    )

    self.entities.each do |record|
      entity_type = EntityType.where(name: record['type']).first_or_create

      target = entity_type.target_class.find_or_initialize_by(vine_id: record['id'])
      target.update_attributes(
        title: record['title']
        )

      entity = Entity.where(entity_type: entity_type,
                            range:       "[#{record['range'][0]}-#{record['range'][0]}]",
                            post:        post,
                            target_id:   target.id
                            ).first_or_create
      entity.update_attributes(
        title: record['title']
        )
    end

    # self.myRepostId
    # self.locale

    self.comments['records'].each do |record|
      user = User.find_or_initialize_by(vine_id: record['userId'])
      user.update_attributes(
        username:          record['username'],
        private:           record['user']['private'],
        verified:          record['verified'],
        location:          record['location'],
        avatar_url:        record['avatarUrl']
      )

      comment = Comment.find_or_initialize_by(vine_id: record['commentId'])
      comment.update_attributes(
        user: user,
        post: post,
        vine_created_at: DateTime.parse(record['created'])
      )

      comment.try('entities').each do |record|
        entity_type = EntityType.find_or_initialize_by(name: record['type'])

        target = entity_type.target_class.find_or_initialize_by(vine_id: record['id'])
        target.update_attributes(
          title: record['title']
          )

        entity = Entity.where(entity_type: entity_type,
                              range:       "[#{record['range'][0]}-#{record['range'][0]}]",
                              comment:     comment,
                              post:        post,
                              target_id:   target.id
                              ).first_or_create
        entity.update_attributes(
          title: record['title']
          )
      end

    end

    self.likes['records'].each do |record|
      user = User.find_or_initialize_by(vine_id: record['userId'])
      user.update_attributes(
        username:          record['username'],
        private:           record['user']['private'],
        verified:          record['verified'],
        location:          record['location'],
        avatar_url:        record['avatarUrl']
      )
      p record
      like = Like.find_or_initialize_by(vine_id: record['likeId'])
      like.update_attributes(
        user: user,
        post: post,
        vine_created_at: DateTime.parse(record['created'])
      )
    end
    post
  end


end
