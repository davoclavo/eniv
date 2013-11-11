require 'open-uri'

class EnivMaker
  VINE_URL = 'https://vine.co/v/'

  VINE_URL_REGEX = /<meta property="twitter:player:stream" content="([^"]+)">/
  VINE_ID_REGEX = /<meta property="twitter:app:url:iphone" content="vine:\/\/post\/(\d+)">/
  VINE_USER_AVATAR_REGEX = /<img src="([^"]+)" class="avatar">/
  VINE_USER_NAME_REGEX = /<h2>([^<]+)<\/h2>/
  VINE_DESCRIPTION_REGEX = /<meta property="twitter:description" content="([^"]+)">/
  VINE_THUMBNAIL_REGEX = /<meta property="twitter:image" content="([^"]+)">/



  TMP_PATH = Rails.root.join 'tmp/enivs'

  attr_accessor :file, :hashed_id, :vine_id, :response, :html, :video_url, :post, :user_id, :user_name, :post_description, :thumbnail_url, :avatar_url

  def initialize(hashed_id)
    self.hashed_id = hashed_id
  end

  def tmp_file_path
    `mkdir -p #{TMP_PATH}`
    File.join TMP_PATH, file_name
  end

  def file_name
    "#{hashed_id}.mp4"
  end

  def vine_url
    VINE_URL + hashed_id
  end

  def scrape_attributes
    response = open(vine_url)
    # response 200?
    self.html = response.read
    self.vine_id = VINE_ID_REGEX.match(html)[1].to_i
    self.video_url = VINE_URL_REGEX.match(html)[1]
    self.avatar_url = VINE_USER_AVATAR_REGEX.match(html)[1]
    self.user_name = VINE_USER_NAME_REGEX.match(html)[1]
    self.post_description = VINE_DESCRIPTION_REGEX.match(html)[1]
    self.thumbnail_url = VINE_THUMBNAIL_REGEX.match(html)[1]
    create_post
  end

  def enivize
    `bash #{Rails.root.join 'lib/scripts/enivize.sh'} #{video_url} #{tmp_file_path}`
  end

  def directory
    Storage.create_directory('reversed/videos')
  end

  def store
    file = directory.files.create({
      :key    => file_name,
      :body   => File.open(tmp_file_path),
      :public => true
    })
    post.update(reversed_video_url: get_public_url)
    post
  end

  def get_file
    self.file = directory.files.get(file_name)
  end

  def get_public_url
    file.public_url if get_file
  end

  def create_post
    user = User.find_or_create_by(avatar_url: avatar_url) do |u|
      u.username = user_name
      u.avatar_url = avatar_url
    end
    self.post = Post.find_or_create_by(vine_id: vine_id) do |p|
      p.hashed_id = hashed_id
      p.reversed_video_url = get_public_url
      p.video_url = video_url
      p.user = user
      p.description = post_description
      p.thumbnail_url = thumbnail_url
    end
  end

  def reverse
    scrape_attributes unless post
    unless get_file
      enivize # delay jobs
      store
    else
      post
    end
  end
end
