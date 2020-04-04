{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeInType    #-}
{-# LANGUAGE TypeOperators #-}
{-# OPTIONS_GHC -Wall      #-}

module Api where

import           Data.Proxy
import           Data.Text (Text)
import           Database.Persist.Sqlite
import           Servant.API
import           Db

{-
data Entry = Entry
    { entryDistance :: Int
    , entryTime     :: UTCTime
    , entryVolume   :: Double
    , entryPpl      :: Double
    , entryPayer    :: Text
    , entryLocation :: Text
    }
  deriving (Show, Generic)
instance ToJSON   Entry
instance FromJSON Entry
-}

type GasApi = "entries" :> QueryParam' '[Optional] "payer" Text
                        :> Get  '[JSON] [Entity Entry]
         :<|> "entry"   :> ReqBody '[JSON] Entry
                        :> Post '[JSON] (EntryId)
         :<|> "entry"   :> Capture "key" EntryId
                        :> Delete '[JSON] NoContent
         :<|> "entry"   :> Capture "key" EntryId
                        :> ReqBody '[JSON] Entry
                        :> Put '[JSON] NoContent
         :<|> "entry"   :> Capture "key" EntryId
                        :> Get '[JSON] (Maybe (Entity Entry))

type AppApi = GasApi :<|> Raw

gasApi :: Proxy GasApi
gasApi = Proxy

appApi :: Proxy AppApi
appApi = Proxy
