module Entries.State exposing (..)

import Return exposing (Return)
import Entry.Types as Entry
import Entries.Types exposing (..)


initialEntries : Entries
initialEntries =
    []


update : Msg -> Entries -> Return Msg Entries
update msg entries =
    Return.singleton entries
        |> Return.zero

