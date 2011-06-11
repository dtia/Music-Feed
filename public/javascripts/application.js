// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var ytplayer;
var videoList;
var videoMarker;

function onYouTubePlayerReady(playerid) {
	ytplayer = document.getElementById("myytplayer");
	ytplayer.addEventListener("onStateChange", "onytplayerStateChange");
	ytplayer.addEventListener("onError", "onyterror");
}

function play() {
  if (ytplayer) {
    ytplayer.playVideo();
  }
}

function onytplayerStateChange(newState) {
	if(newState == -1) {
		ytplayer.playVideo();
	}
	if(newState == 0) {
		playNextVideo();
	}
}

function onyterror(newError) {
	if(newError == 150) {
		playNextVideo();
	}
}

function setVideoList(videoList) {
	this.videoList = videoList;	
}

function getNextVideoObject() {
	if(videoList[videoMarker+1] != null) {
		videoMarker++;
		videoObject = [videoList[videoMarker][0], videoList[videoMarker][1]];
		return videoObject;
	}
	else {
		// redirect to index
		window.location = '/twitterfeeds'
		// console.log("refreshed");
		// console.log("pre-post");
		// 		post_to_url('/twitterfeeds/play_all', {'authenticity_token' : 'd91b5659aa3f7a4105a882ae106912e88a36f2a7'});
		// 		console.log("posted");
	}
}

function getFirstVideo() {
	videoMarker = 0;
	firstVideoTitle = videoList[videoMarker][1];
	$('video_title').innerHTML = firstVideoTitle;
	return videoList[videoMarker][0];
}

function playNextVideo() {
	videoObject = getNextVideoObject();
	// get next video id
	nextVideoId = videoObject[0];
	nextVideoTitle = videoObject[1];
	
	$('video_title').innerHTML = nextVideoTitle;
	ytplayer.loadVideoById(nextVideoId);
	$('video_title').innerHTML = nextVideoTitle;
	ytplayer.loadVideoById(nextVideoId);
}

function post_to_url(path, params, method) {
    method = method || "post"; // Set method to post by default, if not specified.

    // The rest of this code assumes you are not using a library.
    // It can be made less wordy if you use one.
    var form = document.createElement("form");
    form.setAttribute("method", method);
    form.setAttribute("action", path);

    for(var key in params) {
        var hiddenField = document.createElement("input");
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("name", key);
        hiddenField.setAttribute("value", params[key]);

        form.appendChild(hiddenField);
    }

    document.body.appendChild(form);
    form.submit();
}