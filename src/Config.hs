{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Config where

import           Control.Monad.Except (ExceptT, MonadError)
import           Control.Monad.Reader (MonadIO, MonadReader, ReaderT)
import           Database.Persist.Sqlite
import           Servant.Server (ServerError)
import           Network.Wai.Handler.Warp (Port)

newtype AppT m a
    = AppT
    { runApp :: ReaderT Config (ExceptT ServerError m) a
    } deriving
    ( Functor, Applicative, Monad, MonadReader Config, MonadError ServerError, MonadIO )

data Config
    = Config
    { configPool :: ConnectionPool
    , configPort :: Port
    }
