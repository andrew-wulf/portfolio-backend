class Quote < ApplicationRecord
  belongs_to :tweet

  validates :tweet_id, presence: true
  validates :quoted_id, presence: true
  validate :id_difference

  def id_difference
    if self.tweet_id == self.quoted_id
      errors.add(:base, "Tweet cannot quote itself.")
    end
  end

  def quoted
    return Tweet.find_by(id: self.quoted_id)
  end
end
