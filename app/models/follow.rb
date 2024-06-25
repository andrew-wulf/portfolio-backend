class Follow < ApplicationRecord
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate :valid_follow


  def valid_follow
    if self.followed_id == self.follower_id
      errors.add(:base, "User cannot follow self.")
    end

    first_entry = self.class.find_by(follower_id: self.follower_id, followed_id: self.followed_id)
    if first_entry && self.id != first_entry.id
      errors.add(:base, "Follow already exists.")
    end
  end



  def follower
    return User.find_by(id: self.follower_id)
  end

  def following
    return User.find_by(id: self.followed_id)
  end
end
