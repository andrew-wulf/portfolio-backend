class Subtweet < ApplicationRecord
  belongs_to :tweet

  validates :tweet_id, presence: true
  validates :sub_id, presence: true
  validate :id_difference

  def id_difference
    if self.tweet_id == self.sub_id
      errors.add(:base, "Tweet cannot be its own subtweet.")
    end
  end

  def subtweet
    return Tweet.find_by(id: self.sub_id)
  end
end
