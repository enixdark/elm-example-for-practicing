module CounterList where


import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- Model
type alias Model = 
    {
        counters : List (ID, Counter.Model),
        nextID : ID
    }

type alias ID = Int

init : Model
init = {
        counters = [],
        nextID = 0
    }

-- Update
type Action = Insert | Remove ID | Modify ID Counter.Action

update : Action -> Model -> Model
update action model =
    case action of
        Insert ->
            --let newCounter = ( model.nextID, Counter.init 0 )
            --    newCounters = model.counters ++ [ newCounter ]
            --in
                --{
                --    model | counters = newCounters,
                --            nextID = model.nextID + 1
                --}
            {
                model | counters = ( model.nextID, Counter.init 0 ) :: model.counters,
                        nextID = model.nextID + 1
            }
        Remove id ->
            { model | counters = List.filter (\(counterID, _) -> counterID /= id ) model.counters }
        Modify id counterAction ->
            let updateCounter (counterID, counterModel) =
                    if counterID == id then
                         (counterID, Counter.update counterAction counterModel)
                    else (counterID, counterModel)
            in
                {model | counters = List.map updateCounter model.counters}

-- View

view : Signal.Address Action -> Model -> Html
view address model =
    --let counters = List.map (viewCounter address) model.counters
    --    remove = button [ onClick address Remove ] [ text "Remove"]
    --    insert = button [ onClick address Insert ] [ text "Add"]
    --in
    --    div [] ([remove, insert] ++ counters)
    let insert = button [ onClick address Insert] [text "Add"]
    in
        div [] (insert :: List.map (viewCounter address) model.counters)

viewCounter : Signal.Address Action -> (ID, Counter.Model) -> Html
viewCounter address (id,model) =
        --Counter.view (Signal.forwardTo address (Modify id)) model
        let context =
            Counter.Context
                (Signal.forwardTo address (Modify id))
                (Signal.forwardTo address (always (Remove id)))
        in
            Counter.viewWithRemoveButton context model

