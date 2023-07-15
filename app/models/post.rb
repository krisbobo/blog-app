class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :increment_author_posts_counter
  after_destroy :decrement_author_posts_counter

  after_create :update_likes_counter
  after_destroy :update_likes_counter

  def recent_comments
    comments.includes(:author).order(created_at: :desc).limit(5)
  end

  private

  def increment_author_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_author_posts_counter
    author.decrement!(:posts_counter)
  end

  def update_likes_counter
    update(likes_counter: likes.count)
  end
end
