module RandomGifList where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Effects exposing (Effects)
import RandomGif

type alias Model = {
    topics : List (ID, RandomGif.Model),
    netxID : ID
}

type alias ID = Int

init : Model
init = {
    topics = [],
    netxID = 0
}

-- Update

