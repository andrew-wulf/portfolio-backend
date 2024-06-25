class User < ApplicationRecord
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :display_name, presence: true

  has_many :tweets
  has_many :likes
  has_many :retweets

  has_many :following_users, foreign_key: :follower_id, class_name: "Follow"
  has_many :follower_users, foreign_key: :followed_id, class_name: "Follow"

  belongs_to :follower, class_name: "Follow", optional: true
  belongs_to :followed, class_name: "Follow", optional: true


  def followers
    return self.following_users.map {|f| f.follower}
  end

  def following
    return self.follower_users.map {|f| f.following}
  end


  def retweeted_tweets
    return self.retweets.map {|rt| rt.tweet}
  end

  def liked_tweets
    return self.likes.reverse.map {|like| like.tweet}
  end

  def quotes
    output = self.tweets.reverse.filter {|t| t.is_quote}
  end

  def subtweets
    return self.tweets.reverse.filter {|t| t.is_subtweet}
  end



  def content(offset=0, limit=50)

    retweets = Retweet.where(user_id: self.id).offset(offset).limit(limit).map {|rt| rt.tweet}
    tweets = Tweet.where(user_id: self.id).where(is_subtweet: false).offset(offset).limit(limit)

    output = tweets + retweets

    return output.sort.reverse
  end

  def timeline(offset=0, limit=50)
    
    ids = self.following.map {|user| user.id}

    retweets = Retweet.where(user_id: ids).offset(offset).limit(limit).map {|rt| rt.tweet}
    tweets = Tweet.where(user_id: ids).where(is_subtweet: false).offset(offset).limit(limit)

    output = tweets + retweets

    return output.sort.reverse
  end

end