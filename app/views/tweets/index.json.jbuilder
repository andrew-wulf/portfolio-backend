json.array! @tweets do |tweet|
  json.id tweet.id

  json.text tweet.text
  json.image tweet.image
  json.video tweet.video

  json.likes tweet.like_count
  json.retweets tweet.retweet_count
  json.replies tweet.reply_count

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

      json.display_name qt.user.display_name
      json.username qt.user.username
      json.avi qt.user.avi
    end
  end
end