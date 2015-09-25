module SeatSaver where

import Html exposing (..)
import Html.Attributes exposing (..)

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

type Action = NoOp | Refresh Model


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)
    Refresh seats ->
      (seats, Effects.none)


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  ul [ class "seats" ] ( List.map (seatItem address) model )


seatItem : Signal.Address Action -> Seat -> Html
seatItem address seat =
  li [ class "seat available" ] [ text (toString seat.seatNo) ]


-- PORTS

port initialSeats : Signal Model


-- SIGNAL

incomingActions: Signal Action
incomingActions =
  Signal.map Refresh initialSeats


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
