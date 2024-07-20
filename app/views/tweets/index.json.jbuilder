json.array! @tweets do |tweet|

  rt = nil
  if tweet.attributes['tweet_id']
    rt = tweet
    tweet = rt.tweet
  end
  
  json.id tweet.id

  json.text tweet.text
  json.image tweet.image
  json.video tweet.video

  json.timestamp tweet.timestamp
 
  json.likes tweet.like_count
  json.retweets tweet.retweet_count
  json.replies tweet.reply_count
  json.views tweet.views

  json.display_name tweet.user.display_name
  json.username tweet.user.username
  json.avi tweet.user.avi

  json.bio tweet.user.bio
  json.follower_count tweet.user.follower_count
  json.following_count tweet.user.following_count

  json.edited tweet.edited
  json.active tweet.active

  json.is_subtweet tweet.is_subtweet
  json.is_quote tweet.is_quote


  if tweet.is_quote
    qt = tweet.quoted_tweet

    json.quoted_tweet do
      json.id qt.id

      json.text qt.text
      json.image qt.image
      json.video qt.video

      json.likes qt.like_count
      json.retweets qt.retweet_count
      json.replies qt.reply_count
      json.views qt.views
      json.timestamp qt.timestamp

      json.display_name qt.user.display_name
      json.username qt.user.username
      json.avi qt.user.avi

      json.bio qt.user.bio
      json.follower_count qt.user.follower_count
      json.following_count qt.user.following_count
    end
  else
    json.quoted_tweet nil
  end

  if tweet.is_subtweet
    par = tweet.parents[0]

    json.replying_to do
      json.id par.user.id

      json.username par.user.username
      json.email par.user.email

      json.display_name par.user.display_name

      json.avi par.user.avi
      json.verified par.user.verified

      json.bio par.user.bio
      json.follower_count par.user.follower_count
      json.following_count par.user.following_count
    end
  else
    json.replying_to nil
  end

  if @current_user
    json.liked_by_user tweet.liked_by_user(@current_user)
    json.retweeted_by_user tweet.retweeted_by_user(@current_user)
  else
    json.liked_by_user false
    json.retweeted_by_user false
  end


  if rt
    json.is_retweet true
    json.retweeted_by do
      json.id rt.user.id

      json.username rt.user.username
      json.email rt.user.email

      json.display_name rt.user.display_name

      json.bio rt.user.bio
      json.avi rt.user.avi

      json.bio rt.user.bio
      json.follower_count rt.user.follower_count
      json.following_count rt.user.following_count

      json.verified rt.user.verified

      json.followers rt.user.follower_count
      json.following rt.user.following_count
    end

    json.retweeted_at rt.timestamp

  else
    json.retweeted_by nil
    json.retweeted_at nil
  end

end