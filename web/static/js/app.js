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

import socket from "./socket"

var elmDiv = document.getElementById('elm-main')
  , initialState = {
      seatLists: [],
      seatUpdates: {seatNo: 0, occupied: false}
    }
  , elmApp = Elm.embed(Elm.SeatSaver, elmDiv, initialState);

let channel = socket.channel("seats:planner", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on('set_seats', data => {
  console.log('got seats', data.seats)
  elmApp.ports.seatLists.send(data.seats)
})

// listen for seat requests
elmApp.ports.seatRequests.subscribe(seat => {
  channel.push("request_seat", seat)
         .receive("error", payload => console.log(payload.message))
})

channel.on("seat_updated", seat => elmApp.ports.seatUpdates.send(seat))
