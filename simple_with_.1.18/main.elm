import Html exposing (..)


type alias Model = { ... }


type Msg = Reset | ...

update: Msg -> Model -> Model
update Msg model = 
  case msg of
    Reset -> ...


view: Model -> Html Msg
view model = ...