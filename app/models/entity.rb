class Entity < ActiveRecord::Base
  belongs_to :entity_type
  belongs_to :post
  belongs_to :comment

  def from
    return @post if @comment.nil?
    @comment
  end

  def to
    @entity_type.target_class.find(@target_id)
  end
end
