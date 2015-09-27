module SeatSaver where

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import StartApp exposing (App)
import Effects exposing (Effects, Never)
import Task exposing (Task)


-- MODEL

type alias Seat =
  { seatNo : Int
  , occupied : Bool
  }


type alias Model =
  List Seat


initialModel : (Model, Effects Action)
initialModel =
  ([], Effects.none)


-- UPDATE

type Action = NoOp | SetSeats Model | RequestSeat Seat


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)
    SetSeats seats ->
      (seats, Effects.none)
    RequestSeat seat ->
      (model, sendSeatRequest seat)


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  ul [ class "seats" ] ( List.map (seatItem address) model )


seatItem : Signal.Address Action -> Seat -> Html
seatItem address seat =
  li [ class "seat available", onClick address (RequestSeat seat) ] [ text (toString seat.seatNo) ]


-- PORTS

port seatList : Signal Model


port seatRequests : Signal Seat
port seatRequests =
  seatRequestsBox.signal


-- SIGNAL

incomingActions: Signal Action
incomingActions =
  Signal.map SetSeats seatList


seatRequestsBox : Signal.Mailbox Seat
seatRequestsBox =
  Signal.mailbox (Seat 0 False)


-- EFFECTS
sendSeatRequest : Seat -> Effects Action
sendSeatRequest seat =
  Signal.send seatRequestsBox.address seat
    |> Effects.task
    |> Effects.map (always NoOp)


-- WIRING

app : App Model
app =
  StartApp.start
    { init = initialModel
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
