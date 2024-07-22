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
    return self.follower_users.map {|f| f.follower}
  end

  def following
    return self.following_users.map {|f| f.following}
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

  def followed_by_user(user)
    follows = Follow.where(follower_id: user.id, followed_id: self.id)
    return follows.length > 0
  end

  def follows_user(user)
    follows = Follow.where(follower_id: self.id, followed_id: user.id)
    return follows.length > 0
  end

  def content(offset=0, limit=0)

   sql = "
   SELECT id, user_id, timestamp, is_retweet FROM tweets
   WHERE (is_subtweet = FALSE) AND (user_id = #{self.id})
   UNION ALL
   SELECT id, user_id, timestamp, is_retweet FROM retweets
   WHERE user_id = #{self.id}
   ORDER BY timestamp DESC
   OFFSET #{offset}
   LIMIT #{limit};
   "
   records_array = ActiveRecord::Base.connection.execute(sql).values

   output = []

   records_array.each do |row|
     if row[-1]
       item = Retweet.find_by(id: row[0])
     else
       item = Tweet.find_by(id: row[0])
     end
     output.push(item)
   end

   return output
  end


  def timeline(offset=0, limit=200)

    follow_ids = self.following.map {|user| user.id}
   
    if follow_ids.length < 1
      return Tweet.where(user_id: self.id).limit(limit).offset(offset).order(timestamp: :desc)
    end

    follow_string = "(#{follow_ids.join(', ')})"

    self_included = follow_string.sub(")", ", #{self.id})")

    sql = "
    SELECT id, user_id, timestamp, is_retweet FROM tweets
    WHERE (is_subtweet = FALSE) AND (user_id IN #{self_included})
    UNION ALL
    SELECT id, user_id, timestamp, is_retweet FROM retweets
    WHERE user_id IN #{follow_string}
    ORDER BY timestamp DESC
    OFFSET #{offset}
    LIMIT #{limit};
    "
    records_array = ActiveRecord::Base.connection.execute(sql).values

    output = []

    records_array.each do |row|
      if row[-1]
        item = Retweet.find_by(id: row[0])
      else
        item = Tweet.find_by(id: row[0])
      end
      output.push(item)
    end

    return output
  end



  def who_to_follow
    follow_ids = self.following.map {|user| user.id}
    follow_ids.push(self.id)
    return User.where.not(id: follow_ids).order(follower_count: :desc).limit(4)
  end


  def suggested_tweets(offset=0, limit=20)
    follow_ids = self.following.map {|user| user.id}
    follow_ids.push(self.id)
    return Tweet.where.not(user_id: follow_ids).order(views: :desc).limit(limit).offset(offset)
  end

end