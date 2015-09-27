import "deps/phoenix_html/web/static/js/phoenix_html"

import socket from "./socket"

// setup
let elmDiv = document.getElementById('elm-main')
  , initialState = {seatLists: [], seatUpdates: {seatNo: 0, occupied: false}}
  , elmApp = Elm.embed(Elm.SeatSaver, elmDiv, initialState)

// join channel and set initial state
let channel = socket.channel("seats:planner", {})
channel.join()
  .receive("ok", seats => elmApp.ports.seatLists.send(seats))
  .receive("error", resp => console.log("Unable to join", resp))

// listen for seat requests
elmApp.ports.seatRequests.subscribe(seat => {
  channel.push("request_seat", seat)
         .receive("error", payload => console.log(payload.message))
})

// listen for broadcasts
channel.on("updated", seat => elmApp.ports.seatUpdates.send(seat))
