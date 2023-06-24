class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :increment_likes_counter
  after_destroy :decrement_likes_counter

  private

  def increment_likes_counter
    post.increment!(:likes_counter)
  end

  def decrement_likes_counter
    post.decrement!(:likes_counter)
  end
end
