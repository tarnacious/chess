module ParseJson where
{-# LANGUAGE DeriveDataTypeable #-}

import Text.JSON
import Data.Typeable
import Data.Data
import Board
import Moves


data GameState = GameState
    { turn :: PieceColor  
    , board :: [[Square]]
    } deriving (Eq, Show)

instance JSON PieceColor where
  showJSON = \t -> case t of 
                     White -> showJSON "White"
                     Black -> showJSON "Black"
  readJSON (JSString s) = case fromJSString s of 
                            "Black" -> return Black
                            "White" -> return White
                            _ -> fail "PieceColor must be Black or White"
  readJSON _          = fail "Unable to read PieceColor"

toGameState :: State -> GameState
toGameState (turn, moves) = GameState turn moves

toState :: GameState -> State
toState (GameState turn moves) = (turn, moves)

squareFromString :: String -> Maybe Square
squareFromString s = let t = pieceTypeFromString s
                         c = colorFromString s
                         b = blankFromString s in 
                        case b of
                         Just s -> Just s
                         _      -> case t of
                                        Just ti -> case c of
                                           Just ci -> Just (Square (Just (Piece ti ci)))
                                           otherwise -> Nothing
                                        otherwise -> Nothing
                                                               
                                    
blankFromString :: String -> Maybe Square 
blankFromString a | a == "--" = Just (Square Nothing)
                  | otherwise = Nothing

colorFromString :: String -> Maybe PieceColor
colorFromString (a:b:xs) = case b of
                               'B' -> Just Black
                               'W' -> Just White
                               _  -> Nothing
colorFromString _ = Nothing 


pieceTypeFromString :: String -> Maybe PieceType
pieceTypeFromString (a:b:xs) = case a of
                               'K' -> Just King
                               'Q' -> Just Queen
                               'B' -> Just Bishop
                               'N' -> Just Knight
                               'R' -> Just Rook
                               'P' -> Just Pawn
                               _  -> Nothing
pieceTypeFromString _ = Nothing 


instance JSON Square where
  showJSON = \t -> showJSON (show t)
  readJSON (JSString s) = case squareFromString str of 
                            (Just a) -> return a 
                            _ -> fail "Not a valid square"
                      where str = fromJSString s

  readJSON _          = fail "No a valid square"


mLookup a as = maybe (fail $ "No such element: " ++ a) return (lookup a as)

instance JSON GameState where

    showJSON ge = makeObj
        [ ("Turn", showJSON $ turn ge)
        , ("Board", showJSON $ board ge)
        ]
 
    readJSON (JSObject obj) = let
            jsonObjAssoc = fromJSObject obj
        in do
            t <- mLookup "Turn" jsonObjAssoc >>= readJSON
            b <- mLookup "Board" jsonObjAssoc >>= readJSON
            return $ GameState
                { turn = t
                , board = b }


--main = do 
--        f <- readFile "initialBoard"
--        case decode f :: Result GameState of
--            (Ok j) -> putStrLn $ encode j
--            otherwise -> putStrLn "Failed to decode"
                       

