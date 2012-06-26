module Main where

import System.ZMQ
import Control.Monad (forever)
import Data.ByteString.Char8 (pack, unpack)
import Control.Concurrent (threadDelay)

--import Parsing
--import Parser
import ParseJson
import Text.JSON
import Board
import Minimax
import Moves
import Game
import Play

main = withContext 1 $ \context -> do  
  putStrLn "Starting Chess Server"
  withSocket context Rep $ \socket -> do
    bind socket "tcp://*:5555"
  
    forever $ do
      message <- receive socket []
      putStrLn $ unwords ["Received request:", unpack message]    

      case decode (unpack message) :: Result GameState of
        (Ok j) -> send socket (pack (encode (toGameState (doMove (toState j))))) []
        otherwise -> putStrLn "Failed to decode"

--      case (stateParser (unpack message)) of
--          (Just s) -> send socket (pack $ pretty $ Just (doMove s)) []
--          otherwise -> send socket (pack "Error") []
