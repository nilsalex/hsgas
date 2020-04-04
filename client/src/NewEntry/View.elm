module NewEntry.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Entries.Types exposing (Msg(..))

newEntryView : Html Msg
newEntryView =
    tr []
        [ td 
            []
            [ input [ placeholder "km", size 1 ] [] ]
        , td
            []
            [ input [ placeholder "date", size 1 ] [] ]
        , td
            []
            [ input [ placeholder "ℓ", size 1 ] [] ]
        , td
            []
            [ input [ placeholder "€/ℓ", size 1 ] [] ]
        , td
            []
            [ input [ placeholder "€", size 1 ] [] ]
        , td
            []
            [ input [ placeholder "payer", size 1 ] [] ]
        , td
            []
            [ input [ placeholder "place", size 1 ] [] ]
        , td
            []
            [ button [] [ text "\u{271A}" ] ]
        ]

