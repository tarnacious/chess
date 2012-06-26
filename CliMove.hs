--import Parsing
-- import Parser
import Board
import Minimax
import Moves
import Game
import Play
import System.IO
import Text.JSON
import ParseJson

main = do x <- hGetContents stdin 
          case decode x :: Result GameState of
            (Ok j) -> putStrLn $ encode (toGameState (doMove (toState j)))
            otherwise -> putStrLn "Failed to decode"

fromf = do a <- readFile "start.json"
           case decode a :: Result GameState of
                (Ok j) -> putStrLn $ show (toState j)
                otherwise -> putStrLn "Failed to decode"
           


