// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var ytplayer;
var videoList;
var videoMarker;

function onYouTubePlayerReady(playerid) {	
	ytplayer = document.getElementById("myytplayer");
	ytplayer.addEventListener("onStateChange", "onytplayerStateChange");
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

function setVideoList(videoList) {
	this.videoList = videoList;	
}

function getNextVideoObject() {
	if(videoList[videoMarker+1] != null) {
		videoMarker++;
		videoObject = [videoList[videoMarker][0], videoList[videoMarker][1]];
		return videoObject;
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