json.id @tweet.id

json.text @tweet.text
json.image @tweet.image
json.video @tweet.video

json.timestamp @tweet.created_at

json.likes @tweet.like_count
json.retweets @tweet.retweet_count
json.replies @tweet.reply_count
json.views @tweet.views
json.timestamp @tweet.timestamp

json.display_name @tweet.user.display_name
json.username @tweet.user.username
json.avi @tweet.user.avi

json.bio @tweet.user.bio
json.follower_count @tweet.user.follower_count
json.following_count @tweet.user.following_count

json.edited @tweet.edited
json.active @tweet.active

json.is_subtweet @tweet.is_subtweet
json.is_quote @tweet.is_quote

json.subtweets do
  json.array! @tweet.subtweets do |sub|
    json.id sub.subtweet.id

    json.text sub.subtweet.text
    json.image sub.subtweet.image
    json.video sub.subtweet.video

    json.likes sub.subtweet.like_count
    json.retweets sub.subtweet.retweet_count
    json.replies sub.subtweet.reply_count
    json.views sub.subtweet.views
    json.timestamp sub.subtweet.timestamp

    json.display_name sub.subtweet.user.display_name
    json.username sub.subtweet.user.username
    json.avi sub.subtweet.user.avi

    json.bio sub.subtweet.user.bio
    json.follower_count sub.subtweet.user.follower_count
    json.following_count sub.subtweet.user.following_count

    json.edited sub.subtweet.edited
    json.active sub.subtweet.active
  end
end


if @tweet.is_quote
  qt = @tweet.quoted_tweet

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

    json.edited qt.edited
    json.active qt.active
  end
else
  json.quoted_tweet nil
end


if @tweet.is_subtweet
  json.parents do
    json.array! @tweet.parents do |par|
      json.id par.id

      json.text par.text
      json.image par.image
      json.video par.video

      json.likes par.like_count
      json.retweets par.retweet_count
      json.replies par.reply_count
      json.views par.views
      json.timestamp par.timestamp

      json.display_name par.user.display_name
      json.username par.user.username
      json.avi par.user.avi

      json.bio par.user.bio
      json.follower_count par.user.follower_count
      json.following_count par.user.following_count

      json.edited par.edited
      json.active par.active
    end
  end
else
  json.parents nil
end

if @current_user
  json.liked_by_user @tweet.liked_by_user(@current_user)
  json.retweeted_by_user @tweet.retweeted_by_user(@current_user)
else
  json.liked_by_user nil
  json.retweeted_by_user nil
end

