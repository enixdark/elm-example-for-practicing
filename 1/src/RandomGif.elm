module RandomGif where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Effects exposing (Effects, Never)
import Http
import Json.Decode as Json
import Task

type alias Model = {
    topic : String,
    gifUrl : String
}

init : String -> (Model, Effects Action)
init topic =
    (Model topic "public/media/waiting.gif", getRanDomGif topic)



type Action = RequestNone | NewGif (Maybe String)

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        RequestNone ->
            (model, getRanDomGif model.topic)
        NewGif maybeUrl ->
            (
                Model model.topic (Maybe.withDefault model.gifUrl maybeUrl),
                Effects.none
            )

(=>) = (,)

view : Signal.Address Action -> Model -> Html
view address model =
    div[ style [ "width" => "200px"]]
        [
            h2 [headStyle] [text model.topic],
            div [imgStyle model.gifUrl] [],
            button [onClick address RequestNone] [ text "More Please!" ]
        ]

headStyle : Attribute
headStyle =
    style [
        "width" => "200px",
        "text-align" => "center"
    ]

imgStyle : String -> Attribute
imgStyle url =
    style [
        "display" => "inline-block",
        "width" => "200px",
        "height" => "200px", 
        "background-position" => "center center",
        "background-size" => "cover",
        "background-image" => ("url('" ++ url ++ "')")
    ]

--getRanDomGif : String -> Effects Action
--getRanDomGif topic =
--    Http.get decodeUrl (randomUrl topic)
--    |> Task.toMaybe
--    |> Task.map NewGif
--    |> Effects.task

--randomUrl : String -> String
--randomUrl topic =
--    Http.url "http://api.giphy.com/v1/gifs/random"
--     [
--        "api_key" => "dc6zaTOxFJmzC",
--        "tag" => topic
--     ]

--decodeUrl : Json.Decoder String
--decodeUrl =
--    Json.at ["data", "image_url"] Json.string


getRanDomGif : String -> Effects Action
getRanDomGif topic =
  Http.get decodeUrl (randomUrl topic)
    |> Task.toMaybe
    |> Task.map NewGif
    |> Effects.task


randomUrl : String -> String
randomUrl topic =
  Http.url "http://api.giphy.com/v1/gifs/random"
    [ "api_key" => "dc6zaTOxFJmzC"
    , "tag" => topic
    ]


decodeUrl : Json.Decoder String
decodeUrl =
  Json.at ["data", "image_url"] Json.string