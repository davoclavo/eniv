class RemotePost
  include Her::Model
  collection_path "timelines/posts"

  # Create post when fetched
end
