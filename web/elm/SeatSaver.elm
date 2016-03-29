module SeatSaver where

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import StartApp
import Effects exposing (Effects, Never)
import Task exposing (Task)


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [incomingActions]
    }

main : Signal Html
main =
  app.html

port tasks : Signal (Task Never ())
port tasks =
  app.tasks


-- MODEL

type alias Seat =
  { seatNo : Int
  , occupied : Bool
  }


type alias Model =
  List Seat


init : (Model, Effects Action)
init =
  ([], Effects.none)


-- UPDATE

type Action = Toggle Seat | SetSeats Model | RequestSeat Seat | NoOp

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Toggle seatToToggle ->
      let
        updateSeat seatFromModel =
          if seatFromModel.seatNo == seatToToggle.seatNo then
            { seatFromModel | occupied = seatToToggle.occupied }
          else seatFromModel
      in
        (List.map updateSeat model, Effects.none)
    SetSeats seats ->
      (seats, Effects.none)
    RequestSeat seat ->
      (model, sendSeatRequest seat)
    NoOp ->
      (model, Effects.none)


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  ul [ class "seats" ] (List.map (seatItem address) model)


seatItem : Signal.Address Action -> Seat -> Html
seatItem address seat =
  let
    occupiedClass =
      if seat.occupied then "occupied" else "available"
  in
    li
      [ class ("seat " ++ occupiedClass)
      , onClick address (RequestSeat seat)
      ]
      [ text (toString seat.seatNo) ]


-- SIGNALS

port seatLists : Signal Model


port seatRequests : Signal Seat
port seatRequests =
  seatRequestsBox.signal


port seatUpdates: Signal Seat


seatListsToSet: Signal Action
seatListsToSet =
  Signal.map SetSeats seatLists


seatsToUpdate: Signal Action
seatsToUpdate =
  Signal.map Toggle seatUpdates


incomingActions: Signal Action
incomingActions =
  Signal.merge seatListsToSet seatsToUpdate


seatRequestsBox : Signal.Mailbox Seat
seatRequestsBox =
  Signal.mailbox (Seat 0 False)


-- EFFECTS

sendSeatRequest : Seat -> Effects Action
sendSeatRequest seat =
  Signal.send seatRequestsBox.address seat
    |> Effects.task
    |> Effects.map (always NoOp)
