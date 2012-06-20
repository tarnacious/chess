import Parsing
import Parser
import Board
import Minimax
import Moves
import Game

-- putStr $ pretty $ tryplay White initial 

pretty                 :: Maybe Board -> String 
pretty Nothing         = "No board :("
pretty (Just a)        = prettyBoard a

initial                :: Maybe Board
initial                = board $ prettyBoard $ initialBoard 

tryplay                :: PieceColor -> Maybe Board -> Maybe Board
tryplay _ Nothing      = Nothing
tryplay c (Just b)     = Just(getboard(play' c b))

getboard               :: State -> Board
getboard (_, b)        = b                   

play'                   :: PieceColor -> Board -> State
play' color board       = doMove(color, board)

 
