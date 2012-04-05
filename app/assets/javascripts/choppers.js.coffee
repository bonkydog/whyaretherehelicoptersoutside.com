success = (position) ->
  $("#chop_servation_latitude").val(position.coords.latitude)
  $("#chop_servation_longitude").val(position.coords.longitude)
  searchTweets position, 5

printSuccess = (data, textStatus) ->
  console.log data
  console.log textStatus

error = (msg) ->
  s = $("#status")
  s.innerHTML = (if typeof msg is "string" then msg else "failed")
  s.className = "fail"

searchTweets = (position, miles_away) ->
  twitter_api_url = "http://search.twitter.com/search.json"
  $.ajaxSetup cache: true
  $.getJSON twitter_api_url + "?callback=?&rpp=5&q=helicopter%20outside&geocode=" + position.coords.latitude + "," + position.coords.longitude + "," + miles_away + "mi", (data) ->
    if data.results.length > 0
      $.each data.results, (i, tweet) ->
        console.log tweet
        if tweet.text isnt `undefined`
          date_tweet = new Date(tweet.created_at)
          date_now = new Date()
          date_diff = date_now - date_tweet
          hours = Math.round(date_diff / (1000 * 60 * 60))
          tweet_html = "<div class=\"tweet_text\">"
          tweet_html += "<a href=\"http://www.twitter.com/"
          tweet_html += tweet.from_user + "/status/" + tweet.id + "\">"
          tweet_html += tweet.text + "</a></div>"
          tweet_html += "<div class=\"tweet_hours\">" + hours
          tweet_html += " hours ago at " + tweet.location
          if tweet.geo
            tweet_html += "(" + tweet.geo + ")"
          tweet_html += "</div>"
          $("#tweet_container").append tweet_html
    else
      searchTweets(position, miles_away * 2)
$ ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition success, error
  else
    error "not supported"

  $("#yes_reason").click ->
    $("#do_they_know_reason").hide()
    $("#input_reason").show()
    return false;

  $("#yes_chopper").click ->
    $("#chop_servation_sighted").val("true");
    $("#do_they_know_reason").show();
    $("#yes_chopper, #no_chopper").hide();
    return false;

  $("#no_chopper").click ->
    $("#chop_servation_sighted").val("false");
