class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}

  belongs_to :user
  default_scope order: 'microposts.created_at DESC'
  has_many :retweets

  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where("user_id IN (:followed_user_ids) OR user_id = :user_id",
          followed_user_ids: followed_user_ids, user_id: user)
  end

end
