import Parsing
import Parser
import Board
import Minimax
import Moves
import Game
import Play
import System.IO

main = do x <- hGetContents stdin 
          case (stateParser x) of
              (Just s) -> putStr $ pretty $ Just (doMove s)
              otherwise -> putStr "Failed to parse" 
