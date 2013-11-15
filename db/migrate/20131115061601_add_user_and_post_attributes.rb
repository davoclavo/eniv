class AddUserAndPostAttributes < ActiveRecord::Migration
  def change
    add_column :posts , :share_url           , :string
    add_column :posts , :foursquare_venue_id , :string
    add_column :posts , :vine_created_at     , :datetime
    add_column :posts , :video_low_url       , :text

    add_column :posts , :verified            , :boolean
    add_column :posts , :post_to_facebook    , :boolean
    add_column :posts , :post_to_twitter     , :boolean

    add_column :posts , :repost_count        , :integer
    add_column :posts , :like_count          , :integer
    add_column :posts , :post_flags          , :integer



    add_column :users , :description         , :string
    add_column :users , :location            , :string
    add_column :users , :locale              , :string

    add_column :users , :private             , :boolean
    add_column :users , :verified            , :boolean
    add_column :users , :explicit_content    , :boolean
    add_column :users , :reposts_enabled     , :boolean

    add_column :users , :following_count     , :integer
    add_column :users , :follower_count      , :integer
    add_column :users , :post_count          , :integer
    add_column :users , :authored_post_count , :integer
    add_column :users , :like_count          , :integer

  end
end
