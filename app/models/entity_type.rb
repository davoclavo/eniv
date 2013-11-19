class EntityType < ActiveRecord::Base
  has_many :entities

  def target_class
    {
      'mention' => User,
      'tag'     => Tag
    }[self.name]
  end
end
