

function success(position) {
  var s = document.querySelector('#status');
  $("#latitude").val(position.coords.latitude);
  $("#longitude").val(position.coords.longitude);

  searchTweets(position);
}

function error(msg) {
  var s = document.querySelector('#status');
  s.innerHTML = typeof msg == 'string' ? msg : "failed";
  s.className = 'fail';

  // console.log(arguments);
}

$(function() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(success, error);
  } else {
    error('not supported');
  }


  $("#yes_chopper").click(function() {
    $("#sighted").val("true");
  });

  $("#no_chopper").click(function() {
    $("#sighted").val("false");
  });


});


function searchTweets(position) {

  // Declare variables to hold twitter API url and user name
  var twitter_api_url = 'http://search.twitter.com/search.json';

  // Enable caching
  $.ajaxSetup({ cache: true });

  // Send JSON request
  // The returned JSON object will have a property called "results" where we find
  // a list of the tweets matching our request query
  $.getJSON(
    twitter_api_url + '?callback=?&rpp=5&q=helicopter&geocode=' + position.coords.latitude + ',' + position.coords.longitude + ',5mi',
    function(data) {
      $.each(data.results, function(i, tweet) {
        // Uncomment line below to show tweet data in Fire Bug console
        // Very helpful to find out what is available in the tweet objects
        console.log(tweet);

        // Before we continue we check that we got data
        if(tweet.text !== undefined) {
          // Calculate how many hours ago was the tweet posted
          var date_tweet = new Date(tweet.created_at);
          var date_now   = new Date();
          var date_diff  = date_now - date_tweet;
          var hours      = Math.round(date_diff/(1000*60*60));

          // Build the html string for the current tweet
          var tweet_html = '<div class="tweet_text">';
          tweet_html    += '<a href="http://www.twitter.com/';
          tweet_html    += tweet.from_user + '/status/' + tweet.id + '">';
          tweet_html    += tweet.text + '<\/a><\/div>';
          tweet_html    += '<div class="tweet_hours">' + hours;
          tweet_html    += ' hours ago at ' + tweet.location + '(' + tweet.geo + ')';
          tweet_html    += '<\/div>';


          // Append html string to tweet_container div
          $('#tweet_container').append(tweet_html);
        }
      });
    }
  );
}