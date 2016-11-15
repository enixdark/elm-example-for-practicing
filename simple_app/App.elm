module App exposing (..)
import Html exposing (..)
import Html.Events exposing ( onClick )
import Widget

--type alias Model = Bool

--init: (Model, Cmd Msg)
--init = (False, Cmd.none)

--type Msg = Expand | Collapse

--view: Model -> Html Msg
--view model = 
--  if model then
--    div [] 
--      [ button [ onClick Collapse ] [text "Collapse"]
--      , text "Widget"
--      ]
--  else
--    div [] [ button [ onClick Expand ] [ text "Expand"]]

--update: Msg -> Model -> (Model, Cmd Msg)
--update msg model =
--  case msg of
--    Expand ->
--      (True, Cmd.none)
--    Collapse -> 
--      (False, Cmd.none)


--subscriptions: Model -> Sub Msg
--subscriptions model = Sub.none


--main = 
--  Html.program {
--    init = init,
--    view = view,
--    update = update,
--    subscriptions = subscriptions
--  }

type alias AppModel = { widgetModel : Widget.Model }

initialModel: AppModel
initialModel = { widgetModel = Widget.initialModel }

init: (AppModel, Cmd Msg)
init = (initialModel, Cmd.none)

type Msg = WidgetMsg Widget.Msg

view: AppModel -> Html Msg
view model =
  Html.div []
  [
    Html.map WidgetMsg (Widget.view model.widgetModel)
  ]

update: Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
  case message of
    WidgetMsg subMsg ->
      let 
        (updateWidgetModel, widgetCmd) =
            Widget.update subMsg model.widgetModel
      in
        ({ model | widgetModel = updateWidgetModel}, Cmd.map WidgetMsg widgetCmd)

subscriptions: AppModel -> Sub Msg
subscriptions model =
  Sub.none

--main: Program Never
main =
  Html.program {
  init = init,
  view = view,
  update = update,
  subscriptions = subscriptions
  }