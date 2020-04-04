module App.Types exposing (..)

import Entries.Types as Entries


type alias Model =
    { entries : Entries.Entries
    }

type Msg
    = EntriesMsg Entries.Msg
