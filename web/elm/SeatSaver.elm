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
  let
    seats = [ {seatNo = 1, occupied = True}
            , {seatNo = 2, occupied = False}
            ]
  in
    (seats, Effects.none)


-- UPDATE

type Action = NoOp


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  ul [ ] ( List.map (seatItem address) model )


seatItem : Signal.Address Action -> Seat -> Html
seatItem address seat =
  li [ ] [ text (toString seat) ]


-- WIRING

app : App Model
app =
  StartApp.start
    { init = initialModel
    , update = update
    , view = view
    , inputs = []
    }


main : Signal Html
main =
  app.html


port tasks : Signal (Task Never ())
port tasks =
  app.tasks
