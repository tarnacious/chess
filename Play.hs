import Parsing
import Parser
import Board
import Minimax
import Moves
import Game

-- :l Play 
-- putStr $ pretty $ tryplay $ tryplay initial
--
-- getMoves initial

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


getMoves               :: Maybe State -> [(PieceType, (Int, Int), (Int, Int))]
getMoves (Just(c, b))  = concat $ map (\m -> getPieceMoves b m) (colorPos c b) 
getMoves _             = []


getPieceMoves          :: Board -> (Int, Int) -> [(PieceType, (Int, Int), (Int, Int))]
getPieceMoves b p      = case getSquare b p of
                            (Just (Piece t c)) -> case genPieceMoves b p (Piece t c) of
                                           pos -> map (\to -> (t,p,to)) pos
                            otherwise -> []

