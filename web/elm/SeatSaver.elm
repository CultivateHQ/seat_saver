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
    , inputs = []
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
  let
    seats =
      [ { seatNo = 1, occupied = False }
      , { seatNo = 2, occupied = False }
      , { seatNo = 3, occupied = False }
      , { seatNo = 4, occupied = False }
      , { seatNo = 5, occupied = False }
      , { seatNo = 6, occupied = False }
      , { seatNo = 7, occupied = False }
      , { seatNo = 8, occupied = False }
      , { seatNo = 9, occupied = False }
      , { seatNo = 10, occupied = False }
      , { seatNo = 11, occupied = False }
      , { seatNo = 12, occupied = False }
      ]
  in
    (seats, Effects.none)


-- UPDATE

type Action = Toggle Seat

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Toggle seatToToggle ->
      let
        updateSeat seatFromModel =
          if seatFromModel.seatNo == seatToToggle.seatNo then
            { seatFromModel | occupied = not seatFromModel.occupied }
          else seatFromModel
      in
        (List.map updateSeat model, Effects.none)


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
      , onClick address (Toggle seat)
      ]
      [ text (toString seat.seatNo) ]
