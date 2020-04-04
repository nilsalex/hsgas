module Entries.Types exposing (..)

import Http
import Entry.Types as Entry


type alias Entries =
    List Entry.Entry

type Msg
    = EntriesFetched (Result Http.Error Entries)
