class Tweet < ApplicationRecord
  belongs_to :user
  
  has_many :likes
  has_many :retweets

  has_many :subtweets
  has_many :quotes

  validates :user_id, presence: true
  validates :text, length: {minimum: 1, maximum: 140}, allow_blank: true
  validate :has_content


  def view
    self.views +=1
    self.save
  end

  def has_content
    if self.text == nil && self.image == nil && self.video == nil
      errors.add(:base, "Tweet must contain content.")
    end
  end
  
  def reply_count
    return self.replies.length
  end

  def liked_users
    return self.likes.map{|like| like.user}
  end

  def retweeted_users
    return self.retweets.map{|rt| rt.user}
  end

  def replies
    return self.subtweets.map {|sub| sub.subtweet}
  end

  def quotes
    return Quote.where(quoted_id: self.id).map {|q| q.tweet}
  end

  def quoted_tweet
    return Quote.find_by(tweet_id: self.id).quoted
  end

  def parents
    output, curr = [], self
    while true
      parent = Subtweet.find_by(sub_id: curr.id)
      if parent
        output.push(parent.tweet)
        curr = parent.tweet
      else
        break
      end
    end
    return output
  end

  
  def liked_by_user(user)
    likes = Like.where(tweet_id: self.id, user_id: user.id)
    
    return likes.length > 0
  end

  def retweeted_by_user(user)
    retweets = Retweet.where(tweet_id: self.id, user_id: user.id)

    return retweets.length > 0
  end


  def binary_search(arr, val)
    low, high = 0, arr.length - 1
    
    while low <= high
      mid = low + ((high - low) / 2) 

      if arr[mid] == val
        return true
      
      elsif arr[mid] < val
        low = mid + 1
      else
        high = mid - 1
      end
    end
    return false
  end

end
