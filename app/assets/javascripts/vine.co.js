    _V_.options.flash.swf = "//d3422saexnbpnl.cloudfront.net/static/videojs/video-js.swf"
    var mobile = /iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent);
    var ios = /iphone|ipad|ipod/i.test(navigator.userAgent)
    var android = /android/i.test(navigator.userAgent);
    var ipad = /ipad/i.test(navigator.userAgent);

    var player;
    function resize() {
        var videoContainerSize = $('.video-container').width();

        var showVolumeControl = true;
        if (ios) {
            
            showVolumeControl = false;
        }

        if (android) {
            
            showVolumeControl = false;
        }

        if (showVolumeControl) $('.mute-button').show();
        else $('.mute-button').hide();

        player.width(videoContainerSize);
        player.height(videoContainerSize);

        var shareContainer = $('.share-page .card .info');
        var shareTop = $('.share-page .card .user');
        var shareMiddle = $('.share-page .card h1');
        var shareBottom = $('.share-page .card .shot-with-vine');

        shareMiddle.height(shareContainer.outerHeight() - shareTop.outerHeight() - shareBottom.outerHeight()); 
    }

    $(function () {
        player = videojs('post', { 'children': { 'loadingSpinner': false, 'controlBar': false }}).ready(function () {
            player = this;
            resize();

            this.load();
            var once = false;
            f = function() {
                if (once) { return; }
                once = true;

                if ($.cookie("post_page_volume")) {
                    $('.mute-button').removeClass('off');
                    $('.mute-button').addClass('on');
                    player.volume(1);
                } else {
                    this.volume(0);
                }

                if (!mobile)
                    this.play();
            };

            
            this.on('canplaythrough', f)
            this.on('canplay', f)

            if (ipad) {
                
                $('video')[0].controls = true;
                this.on('play', function() { $('video')[0].controls = false; });
            }

            if (android) {
                
                $('video')[0].loop = false;
            }
        });

        $('.mute-button').click(function (e) {
            if (player.volume() == 0) {
                $(e.target).removeClass('off');
                $(e.target).addClass('on');
                player.volume(1);
                player.currentTime(0.1);
                $.cookie("post_page_volume", 1, {expires: 365});
            } else {
                $(e.target).removeClass('on');
                $(e.target).addClass('off');
                player.volume(0);
                $.removeCookie("post_page_volume");
            }
            return false;
        });

        $('.overlay').click(function () {
            if (player.paused())
                player.play()
            else
                player.pause()
        });

        $(window).resize(resize);
    });
