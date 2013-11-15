require 'open-uri'

class EnivMaker

  TMP_PATH = Rails.root.join 'tmp/enivs'

  def initialize(post)
    @post = post
  end

  def tmp_file_path
    `mkdir -p #{TMP_PATH}`
    File.join TMP_PATH, file_name
  end

  def file_name
    "#{@post.hashed_id}.mp4"
  end

  def enivize
    `bash #{Rails.root.join 'lib/scripts/enivize.sh'} #{@post.video_url} #{tmp_file_path}`
  end

  def directory
    Storage.create_directory('reversed/videos')
  end

  def store_file
    @file = directory.files.create({
      :key    => file_name,
      :body   => File.open(tmp_file_path),
      :public => true
    })
    @post.update(reversed_video_url: @file.public_url)
  end

  def get_file
    @file = directory.files.get(file_name)
  end

  def reverse
    unless get_file
      enivize
      store_file
    end
  end
end
