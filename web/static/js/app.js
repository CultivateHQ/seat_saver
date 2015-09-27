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
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

let elmDiv = document.getElementById('elm-main')
  , initialState = {seatList: []}
  , elmApp = Elm.embed(Elm.SeatSaver, elmDiv, initialState)

let channel = socket.channel("seats:planner", {})
channel.join()
  .receive("ok", seats => elmApp.ports.seatList.send(seats))
  .receive("error", resp => console.log("Unable to join", resp))

elmApp.ports.seatRequests.subscribe(seat => {
  console.log('Requesting seat: ', seat)
  channel.push("request_seat", seat)
         .receive("error", payload => console.log(payload.message)
})

channel.on("updated", seat => console.log('updated seat: ', seat))
