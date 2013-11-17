$(function() {
  var date = gon.created_at.split(/\D/);
  var creationDate = new Date(date[0], parseInt(date[1], 10) - 1, date[2], date[3], date[4], date[5], date[6]);

  var now = new Date();
  var now_utc = new Date(now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate(),  now.getUTCHours(), now.getUTCMinutes(), now.getUTCSeconds());
  var fromNow = Math.floor(now_utc.getTime() - creationDate.getTime()) / 1000;
  var relativeTime = '';

  if (fromNow < 1) {
    relativeTime = 'Now';
  } else if (fromNow < 60) {
    relativeTime = fromNow + ' sec ago';
  } else if (fromNow < 3600) {
    relativeTime = Math.floor(fromNow / 60) + ' min ago';
  } else if (fromNow < 86400) {
    relativeTime = Math.floor(fromNow / 60 / 60);
    if (relativeTime === 1) {
      relativeTime += ' hour ago';
    } else {
      relativeTime += ' hours ago';
    }
  } else if (fromNow < 157680000) {
    relativeTime = Math.floor(fromNow / 60 / 60 / 24);
    if (relativeTime === 1) {
      relativeTime += ' day ago';
    } else {
      relativeTime += ' days ago';
    }
  }

  $('.timestamp').text(relativeTime);
  $('.share-page').addClass('ready');

  var pageUrl = gon.share_url;
  function formatCount(count) {
    var countK = count / 1000;
    if (countK < 1) {
      return count;
    } else if (countK < 10) {
      var countStr = count + "";
      return [countStr.substr(0, 1), countStr.substr(1, 3)].join(',');
    } else {
      return (Math.floor(countK * 10) / 10) + "K";
    }
  }

  $.ajax({
    url: 'https://graph.facebook.com/?ids=' + pageUrl,
    success: function(data) {
      if (data && data[pageUrl] && data[pageUrl].shares) {
        $('.share-badge.facebook p').html(formatCount(data[pageUrl].shares));
      }
      $('.share-overlay').addClass('fb-ready');
    },
    error: function() { $('.share-overlay').addClass('fb-ready'); }
  });
  $.ajax({
    url: 'https://cdn.api.twitter.com/1/urls/count.json?url=' + pageUrl,
    dataType: 'jsonp',
    success: function(data) {
      if (data && data.count) {
        $('.share-badge.twitter p').html(formatCount(data.count));
      }
      $('.share-overlay').addClass('twitter-ready');
    },
    error: function() { $('.share-overlay').addClass('twitter-ready'); }
  });

  var $tweetButton = $('.share-badge.twitter').closest('a');
  var $fbShareButton = $('.share-badge.facebook').closest('a');

  var description = gon.description;
  if (description.length > 116) {
    description = description.substr(0, 115).trim() + '\u2026';
  }
  var tweetOptions = {
    url: pageUrl,
    text: description,
    related: 'vineapp'
  };
  $tweetButton.attr('href', 'https://twitter.com/share?' + $.param(tweetOptions));
  $tweetButton.click(function(event) {
    event.preventDefault();
    var width = 550;
    var height = 380;
    var tweetWindow = window.open(this.href, 'tweetWindow', 'width=' + width + ',height=' + height);
    tweetWindow.moveTo((screen.width - width) / 2,(screen.height - height) / 2);
  });

  $fbShareButton.attr('href', 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(pageUrl));
  $fbShareButton.click(function(event) {
    event.preventDefault();
    var width = 670;
    var height = 350;
    var fbWindow = window.open(this.href, 'tweetWindow', 'width=' + width + ',height=' + height);
    fbWindow.moveTo((screen.width - width) / 2,(screen.height - height) / 2);
  });

  var $container = $('#container');
  var $video = $('#video');
  var $audio = $('.mute-button');

  var android = /android/i.test(navigator.userAgent);
  var ipad = /ipad/i.test(navigator.userAgent);
  var ios = ipad || /iphone|ipod/i.test(navigator.userAgent);
  var windows = /Windows Phone/i.test(navigator.userAgent);
  var mobile = ios || android || windows || /blackberry|mini|palm/i.test(navigator.userAgent);

  
  
  if (ios || android || windows) {
    $audio.hide();
  }

  if (!mobile) {
    $('.share-page').addClass('not-mobile');
  }

  var videoSize = $container.width();
  $container.height(videoSize);

  var unmuted = $.cookie('post_page_volume');
  var options = {
    size: videoSize,
    width: videoSize,
    height: videoSize,
    autoplay: !mobile,
    muted: $audio.is(':visible') && !unmuted,
    
    swf: "//d3422saexnbpnl.cloudfront.net/static/bower_components/divine-player-swf/release/divine-player.swf"
  };

  DivinePlayer($video[0], options, function(player) {
    $audio.click(function(event) {
      event.preventDefault();
      player.muted() ? unmute() : mute();
    });

    var $videoEl;
    if (mobile) {
      $videoEl = $('.overlay')
    } else {
      $videoEl = $container;
    }
    $videoEl.click(function() {
      player.paused() ? player.play() : player.pause();
    });

    function mute() {
      $audio.removeClass('on');
      player.mute();
      $.removeCookie("post_page_volume");
    }

    function unmute() {
      $audio.addClass('on');
      player.unmute();
      $video[0].currentTime = 0;
      $.cookie("post_page_volume", 1, { expires: 365 });
    }
  });

  $(window).resize (function() {
    var videoSize = Math.min($container.width());
    $('#container').height(videoSize);
  });
});
