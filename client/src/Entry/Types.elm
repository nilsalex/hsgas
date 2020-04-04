module Entry.Types exposing (..)

import Http

type alias Date =
    { year : Int
    , month : Int
    , day : Int
    }

type alias Entry =
    { distance : Int
    , time : String
    , volume : Float
    , ppl : Float
    , payer : String
    , location : String
    }
