module RandomGifPair where

import Effects exposing (Effects)
import Html exposing (..)
import Html.Attributes exposing (..)
import RandomGif

-- Model
type alias Model =
    {
        left : RandomGif.Model,
        right : RandomGif.Model
    }

init : String -> String -> (Model, Effects Action)
init left right =
    let (l,lfx) = RandomGif.init left 
        (r,rfx) = RandomGif.init right
    in
        (
            Model l r,
            Effects.batch [
                Effects.map Left lfx,
                Effects.map Right rfx
                ]
        )

-- UPDATE

type Action = Left RandomGif.Action | Right RandomGif.Action

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        Left act ->
            let (l,fx) = RandomGif.update act model.left
            in
                ( Model l model.right,
                  Effects.map Left fx
                )
        Right act ->
            let (r, fx) = RandomGif.update act model.right
            in (Model model.left r,
                Effects.map Right fx
                )

view : Signal.Address Action -> Model -> Html
view address model =
  div [ style [ ("display", "flex") ] ]
    [ RandomGif.view (Signal.forwardTo address Left) model.left
    , RandomGif.view (Signal.forwardTo address Right) model.right
    ]