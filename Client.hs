module Main where 
import System.ZMQ
import Control.Monad (forM_)
import Data.ByteString.Char8 (pack, unpack)

main = do 
  withContext 1 $ \context -> do  
      putStrLn "Connecting to Chess server..."  
      withSocket context Req $ \socket -> do
        do 
            start <- readFile "start.json"
            connect socket "tcp://localhost:5555"
            sender socket start 10

sender _ _ 0 = do
      putStrLn "Done"
sender socket request loops = do
      putStrLn $ unwords ["Sending request", show loops]
      send socket (pack request) []
    
      reply <- receive socket []
      putStrLn $ unwords ["Received reply:", unpack reply]    
      sender socket (unpack reply) (loops - 1)


