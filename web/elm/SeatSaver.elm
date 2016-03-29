module SeatSaver where

import Html exposing (ul, li, text)
import Html.Attributes exposing (class)

main =
  view init


-- MODEL

type alias Seat =
  { seatNo : Int
  , occupied : Bool
  }


type alias Model =
  List Seat


init =
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


-- VIEW

view model =
  ul [ class "seats" ] (List.map seatItem model)

seatItem seat =
  li [ class "seat available" ] [ text (toString seat.seatNo) ]
