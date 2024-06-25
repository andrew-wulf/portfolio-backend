json.id @tweet.id

json.text @tweet.text
json.image @tweet.image
json.video @tweet.video

json.likes @tweet.like_count
json.retweets @tweet.retweet_count
json.replies @tweet.reply_count

json.display_name @tweet.user.display_name
json.username @tweet.user.username
json.avi @tweet.user.avi

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

    json.display_name sub.subtweet.user.display_name
    json.username sub.subtweet.user.username
    json.avi sub.subtweet.user.avi

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

    json.display_name qt.user.display_name
    json.username qt.user.username
    json.avi qt.user.avi

    json.edited qt.edited
    json.active qt.active
  end
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

      json.display_name par.user.display_name
      json.username par.user.username
      json.avi par.user.avi

      json.edited par.edited
      json.active par.active
    end
  end
end

