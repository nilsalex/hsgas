module App.View exposing (..)

import App.Types exposing (Model, Msg(..))
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Entries.View as Entries

root : Model -> Html Msg
root model =
    div []
        [ headerView model
        , entriesView model
        ]

headerView : Model -> Html Msg
headerView model = div [] []

entriesView : Model -> Html Msg
entriesView model =
    div []
        [ Html.map EntriesMsg <| Entries.listView model.entries
        ]
