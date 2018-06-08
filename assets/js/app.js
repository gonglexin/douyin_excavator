// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

import { Ajax } from "phoenix";

let searchButton = document.querySelector("#search")

searchButton.addEventListener("click", event => {
  let query = document.querySelector("#query").value

  let button = event.target
  button.classList.add('is-loading')
  //  Ajax.request("POST", "/api/aweme", "application/json", "", 1000, onTimeout, callback);
  let body = {query: query}
  Ajax.request(
    "POST", "/api/aweme",
    "application/json", JSON.stringify(body),
    10000, null,
    function(res) {
      button.classList.remove('is-loading');
      renderVideos(res.data)
    });
});

function video_url(video_id) {
  return 'https://aweme.snssdk.com/aweme/v1/play/?line=0&ratio=720p&media_type=4&vr_type=0&test_cdn=None&improve_bitrate=0&video_id=' + video_id
}

function renderVideos(videos) {
  var videosDiv = document.getElementById("videos")
  videosDiv.innerHTML = ''
  videos.forEach(function(video) {
    var div = document.createElement('div')
    div.setAttribute('class', 'column is-2-desktop is-half-mobile is-one-third-tablet')
    var v = document.createElement('video')
    v.setAttribute('controls', 'controls')
    v.setAttribute('class', 'video')
    v.setAttribute('name', 'media')
    v.setAttribute('preload', 'none')
    v.setAttribute('poster', video.i)
    var src = document.createElement('source')
    src.setAttribute('src', video_url(video.v))
    src.setAttribute('type', 'video/mp4')
    v.appendChild(src)

    div.appendChild(v)
    videosDiv.appendChild(div)
  })
}
