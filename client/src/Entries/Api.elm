module Entries.Api exposing (getEntries)

import Http
import Json.Decode as Decode exposing (Decoder)
import Entry.Types as Entry
import Entries.Types exposing (..)


getEntries : Cmd Msg
getEntries =
    Http.get
        { url = "http://192.168.178.77:3434/entries/"
        , expect = Http.expectJson EntriesFetched entriesDecoder
        }

entryDecoder : Decoder Entry.Entry
entryDecoder =
    Decode.map6 Entry.Entry
        (Decode.field "distance" Decode.int)
        (Decode.field "time" Decode.string)
        (Decode.field "volume" Decode.float)
        (Decode.field "ppl" Decode.float)
        (Decode.field "payer" Decode.string)
        (Decode.field "location" Decode.string)

entriesDecoder : Decoder (List Entry.Entry)
entriesDecoder =
    Decode.list entryDecoder
