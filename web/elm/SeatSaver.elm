module SeatSaver where

import Html exposing (..)
import Html.Attributes exposing (..)


main =
  view


view =
  div [ class "jumbotron" ]
    [ h2 [ ] [ text "Welcome to Elm!" ]
    , p [ class "lead" ]
      [ text "The best of functional programming in your browser" ]
    ]
