json.array! @tweets do |tweet|

  retweet = false

  if tweet.attributes['tweet_id']
    rt = tweet
    json.is_retweet true
    json.retweeted_by do
      json.id rt.user.id

      json.username rt.user.username
      json.email rt.user.email

      json.display_name rt.user.display_name

      json.bio rt.user.bio
      json.avi rt.user.avi

      json.verified rt.user.verified

      json.followers rt.user.followers
      json.following rt.user.following
    end

    json.retweeted_at rt.timestamp
    tweet = rt.tweet
    retweet = true
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
    end
  end

  if tweet.is_subtweet
    par = tweet.parents[0]

    json.replying_to do
      json.id par.user.id

      json.username par.user.username
      json.email par.user.email

      json.display_name par.user.display_name

      json.bio par.user.bio
      json.avi par.user.avi

      json.verified par.user.verified

      json.followers par.user.followers
      json.following par.user.following
    end
  end

  if @current_user
    json.liked_by_user tweet.liked_by_user(@current_user)
    json.retweeted_by_user tweet.retweeted_by_user(@current_user)
  end
end