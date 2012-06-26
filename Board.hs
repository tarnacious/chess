module Board where
import Data.Char
import Utils

-- **************** data types *******************

data Piece = Piece {pieceType::PieceType, pieceColor::PieceColor} deriving Eq
data PieceType = Rook | Knight | Bishop | King | Queen | Pawn deriving Eq
data PieceColor = Black | White deriving Eq

data Square = Square (Maybe Piece) deriving Eq


--type Square = Maybe Piece

type Board = [[Square]]

type Pos = (Int, Int)

-- **************** output functions *******************

prettyBoard::Board->String
prettyBoard  = unlines . map (concatMap show)

prettyBoardIndent::Int->Board->String
prettyBoardIndent x = ('\n':) . concatMap ((('\n':take x (repeat ' '))++) . concatMap show)

instance Show PieceColor where
 show Black = "B"
 show White = "W"

instance Show PieceType where
 show King = "K"
 show Queen = "Q"
 show Knight = "N"
 show Rook = "R"
 show Bishop = "B"
 show Pawn = "P"

instance Show Piece where
 show (Piece a b) = show a ++ show b

instance Show Square where
 show (Square (Just p)) = show p
 show (Square Nothing) = "--"

-- **************** auxiliary board functions *******************

oppositeColor::PieceColor->PieceColor
oppositeColor White = Black
oppositeColor Black = White

isEmpty::Board->Pos->Bool
isEmpty board pos = (Square Nothing) == getSquare board pos

emptySquare::Square
emptySquare = Square Nothing

getSquare::Board->Pos->Square
getSquare board (a, b) = board!!a!!b

updateBoard::Pos->Square->Board->Board
updateBoard = updateMatrix

deleteSquare::Pos->Board->Board
deleteSquare p = updateBoard p emptySquare

-- moves the piece at p1 to p2
movePos::Pos->Pos->Board->Board
movePos p1 p2 b = updateBoard p2 (getSquare b p1) (deleteSquare p1 b)

move::String->String->Board->Board
move p1 p2 = movePos (toPos p1) (toPos p2)

-- computes the internal representation of "a1:h8"
toPos::String->Pos
toPos [x, y] = (7 - (ord y - ord '1'), ord x - ord 'a')

outside,inside::Pos->Bool
outside (a, b) = a < 0 || b < 0 || a > 7 || b > 7

inside = not . outside

colorPos::PieceColor->Board->[Pos]
colorPos f board = [(a, b)|a<-[0..7],b<-[0..7], hasColor f (getSquare board (a,b))]

hasColor::PieceColor->Square->Bool
hasColor _ (Square Nothing) = False
hasColor f1 (Square (Just (Piece a f2))) = f1 == f2

-- **************** some boards *******************

initialBoard, emptyBoard::Board
initialBoard = map (\row -> map (\p -> Square p) row) [[Just (Piece Rook Black), Just (Piece Knight Black), Just (Piece Bishop Black), Just (Piece Queen Black), Just (Piece King Black), Just (Piece Bishop Black), Just (Piece Knight Black), Just (Piece Rook Black)],
                [Just (Piece Pawn Black), Just (Piece Pawn Black), Just (Piece Pawn Black), Just (Piece Pawn Black), Just (Piece Pawn Black), Just (Piece Pawn Black), Just (Piece Pawn Black), Just (Piece Pawn Black)],
                [Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing],
                [Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing],
                [Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing],
                [Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing],
                [Just (Piece Pawn White), Just (Piece Pawn White), Just (Piece Pawn White), Just (Piece Pawn White), Just (Piece Pawn White), Just (Piece Pawn White), Just (Piece Pawn White), Just (Piece Pawn White)],
                [Just (Piece Rook White), Just (Piece Knight White), Just (Piece Bishop White), Just (Piece Queen White), Just (Piece King White), Just (Piece Bishop White), Just (Piece Knight White), Just (Piece Rook White)]]

emptyBoard = [[Square Nothing|_<-[1..8]]|_<-[1..8]]

