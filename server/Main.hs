{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Main where

import Api
import Config
import Db

import           Control.Exception          (bracket)
import           Control.Monad.Except       (MonadIO)
import           Control.Monad.Reader       (runReaderT)
import           Control.Monad.Logger       (runStdoutLoggingT)
import           Data.Text                  (Text)
import           Data.Proxy                 (Proxy(..))
import           Database.Persist.Sqlite
import           Data.Pool                  (destroyAllResources)
import           Network.Wai.Handler.Warp   (run)
import           Servant.API
import           Servant.JS                 (writeJSForAPI, vanillaJS)
import           Servant.Server
import           Servant.Server.StaticFiles

serveGasApi :: MonadIO m => ServerT GasApi (AppT m)
serveGasApi = serveList
         :<|> serveAdd
         :<|> serveDelete
         :<|> serveUpdate
         :<|> serveRead
  where
    serveList :: MonadIO m => Maybe Text -> AppT m [Entity Entry]
    serveList Nothing = runDb $ selectList [] [Asc EntryDistance]
    serveList (Just name) = runDb $ selectList [Filter EntryPayer (Left name) Eq] [Asc EntryDistance]

    serveAdd :: MonadIO m => Entry -> AppT m EntryId
    serveAdd = runDb . insert

    serveDelete :: MonadIO m => EntryId -> AppT m NoContent
    serveDelete key = runDb (delete key) >> return NoContent

    serveUpdate :: MonadIO m => EntryId -> Entry -> AppT m NoContent
    serveUpdate key entry = runDb (replace key entry) >> return NoContent

    serveRead :: MonadIO m => EntryId -> AppT m (Maybe (Entity Entry))
    serveRead key = runDb (selectFirst [EntryId ==. key] [])

files :: Server Raw
files = serveDirectoryFileServer "assets"

generateJavascript :: IO ()
generateJavascript =
    writeJSForAPI (Proxy :: Proxy GasApi) vanillaJS "./assets/api.js"

initialize :: Config -> IO Application
initialize cfg = do
  generateJavascript
  runSqlPool doMigrations (configPool cfg)
  pure . app $ cfg

acquireConfig :: IO Config
acquireConfig = do
    pool <- runStdoutLoggingT $ createSqlitePool "db/data.db" 8
    let port = 3434
    pure $ Config pool port

app :: Config -> Application
app cfg = serve appApi (appToServer cfg :<|> files)

convertApp :: Config -> AppT IO a -> Handler a
convertApp cfg appt = Handler $ runReaderT (runApp appt) cfg

appToServer :: Config -> Server GasApi
appToServer cfg = hoistServer gasApi (convertApp cfg) serveGasApi

shutdownApp :: Config -> IO ()
shutdownApp cfg = destroyAllResources (configPool cfg)

main :: IO ()
main = bracket acquireConfig shutdownApp $
         (\cfg -> run (configPort cfg) =<< initialize cfg)
