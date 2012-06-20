import Parsing
import Parser
import Board
import Minimax
import Moves
import Game

-- :l Play 
-- putStr $ pretty $ tryplay $ tryplay initial

pretty                 :: Maybe State -> String 
pretty Nothing         = "No board :("
pretty (Just a)        = case a of 
                            (White, c) -> "White \n\n" ++ (prettyBoard c)
                            (Black, c) -> "Black \n\n" ++ (prettyBoard c)
                            
initial                :: Maybe State
initial                = case (boardParser $ prettyBoard $ initialBoard) of
                            (Just b) -> Just (White, b)
                            otherwise -> Nothing 

tryplay                :: Maybe State -> Maybe State
tryplay Nothing        = Nothing
tryplay (Just b)       = Just (doMove b) 


