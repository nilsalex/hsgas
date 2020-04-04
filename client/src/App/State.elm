module App.State exposing (..)

import App.Types exposing (..)
import Return exposing (Return)
import Entries.Api as Entries
import Entries.State as Entries
import Entries.Types as Entries


initialModel : Model
initialModel =
    { entries = Entries.initialEntries
    }


initialCommand : Cmd Msg
initialCommand =
    Cmd.map EntriesMsg Entries.getEntries


update : Msg -> Model -> Return Msg Model
update msg model =
    Return.singleton model
        |> (case msg of
                EntriesMsg msg_ ->
                    updateEntries msg_
           )


updateEntries : Entries.Msg -> Return Msg Model -> Return Msg Model
updateEntries msg writer =
    let
        ( appModel, _ ) =
            writer

        ( entriesModel, entriesCmd ) =
            Entries.update msg appModel.entries
    in
    writer
        |> (case msg of
                Entries.EntriesFetched (Ok entries) ->
                    Return.map <|
                        \m -> {m | entries = entries}
                _ ->
                    Return.mapWith
                        (\m -> { m | entries = entriesModel })
                        (Cmd.map EntriesMsg entriesCmd)
           )
