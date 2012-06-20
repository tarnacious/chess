module Parser where
import Parsing
import Board

board                  :: String -> Maybe Board 
board s                = board' (parse rows s)

board'                 :: [(Board,String)] -> Maybe Board
board' []              = Nothing
board' [(b, "")]       = Just(b)
board' [(_, _)]        = Nothing

row                   :: Parser[Square]
row                   = do m <- take' square 8
                           return m

rows                  :: Parser Board
rows                  = take' row 8

blank                 :: Parser Square
blank                 =  do Parsing.char '-'
                            Parsing.char '-'
                            return Nothing

black                 :: Parser PieceColor
black                 =  do Parsing.char 'B'
                            return Black

white                 :: Parser PieceColor
white                 =  do Parsing.char 'W'
                            return White

color                 :: Parser PieceColor
color                 = white +++ black

king                  :: Parser PieceType
king                  =  do Parsing.char 'K'
                            return King

queen                 :: Parser PieceType
queen                 =  do Parsing.char 'Q'
                            return Queen

knight                :: Parser PieceType
knight                =  do Parsing.char 'N'
                            return Knight

bishop                :: Parser PieceType
bishop                =  do Parsing.char 'B'
                            return Bishop

rook                  :: Parser PieceType
rook                  =  do Parsing.char 'R'
                            return Rook

pawn                  :: Parser PieceType
pawn                  =  do Parsing.char 'P'
                            return Pawn

pieceType'            :: Parser PieceType
pieceType'            =  pawn +++ rook +++ knight +++ bishop +++ queen +++ king

piece                 :: Parser Square
piece                 =  do t <- pieceType'
                            c <- color
                            return (Just (Piece t c))

square'               :: Parser Square
square'               = blank +++ piece

square                :: Parser Square
square                = token square'
