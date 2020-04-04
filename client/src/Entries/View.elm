module Entries.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Entry.Types exposing (..)
import Entries.Types exposing (..)
import NewEntry.View exposing (newEntryView)

import List exposing (append)

import Round
import Parser exposing (..)
import Char exposing (isDigit)

checkInt : String -> Parser Int
checkInt str =
    case String.toInt str of
        Just i  -> succeed i
        Nothing -> problem <| "Could not parse " ++ str ++ " as Int"

parserDate : Parser Date
parserDate =
    succeed Date
    |= (andThen checkInt <| getChompedString <| chompWhile Char.isDigit)
    |. symbol "-"
    |= (andThen checkInt <| getChompedString <| chompWhile Char.isDigit)
    |. symbol "-"
    |= (andThen checkInt <| getChompedString <| chompWhile Char.isDigit)
    |. symbol "T"

listHeader : Html Msg
listHeader = 
    tr []
        [ td 
            []
            [ p
                []
                [ text "km" ]
            ]
        , td
            []
            [ p
                []
                [ text "date" ]
            ]
        , td
            []
            [ p
                []
                [ text "ℓ" ]
            ]
        , td []
             [ p
                []
                [ text "€/ℓ" ]
             ]
        , td []
             [ p
                []
                [ text "€" ]
             ]
        , td []
             [ p
                []
                [ text "paid by" ]
             ]
        , td []
             [ p
                []
                [ text "where" ]
             ]
        , td []
             []
        ]


listView : Entries -> Html Msg
listView entries =
    ul []
        (append (listHeader :: List.map itemView entries) [newEntryView])


dateView : Date -> Html Msg
dateView {year, month, day} = text <|
                              String.fromInt day ++ "." ++
                              String.fromInt month ++ "." ++
                              String.fromInt year

itemView : Entry -> Html Msg
itemView entry =
    let
        date = case run parserDate entry.time of
                 Ok date_ -> dateView date_
                 Err _    -> text <| "Error parsing " ++ entry.time

    in
    tr []
        [ td 
            []
            [ p
                []
                [ text <| String.fromInt entry.distance ]
            ]
        , td
            []
            [ p
                []
                [ date ]
            ]
        , td
            []
            [ p
                []
                [ text <| Round.round 2 entry.volume ]
            ]
        , td
            []
            [ p
                []
                [ text <| Round.round 3 entry.ppl ]
            ]
        , td
            []
            [ p
                []
                [ text <| Round.round 2 (entry.ppl * entry.volume) ]
            ]
        , td
            []
            [ p
                []
                [ text entry.payer ]
            ]
        , td
            []
            [ p
                []
                [ text entry.location ]
            ]
        , td []
             [ button [] [ text "\u{2716}" ] ]
        ]

