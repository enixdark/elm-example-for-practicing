import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Debug
import Http 
import Task
--import Json
import Json.Decode as Json exposing (..)

type alias Model =
  {
    topic : String,
    gifUrl : String
  }

init: String -> (Model, Cmd Msg)
init topic = (Model topic "waiting.gif", getRandomGif topic)

type Msg = 
  MorePlease | NewGif (Result Http.Error String)


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      (model, getRandomGif model.topic)
    NewGif (Ok newUrl) ->
      (Model model.topic newUrl, Cmd.none)
    NewGif (Err _) ->
      (model, Cmd.none)

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let 
    url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Http.send NewGif (Http.get url decodeGifUrl)

decodeGifUrl: Json.Decoder String
decodeGifUrl = 
  Json.at ["data", "image_url"] Json.string

view: Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , button [ onClick (NewGif (Ok model.topic)) ] [ text "New" ]
    , br [] []
    , img [src model.gifUrl] []
  ]

subscriptions: Model -> Sub Msg
subscriptions model = Sub.none

main = 
  Html.program
    { init = init "cats"
      , view = view
      , update = update
      , subscriptions = subscriptions
    }