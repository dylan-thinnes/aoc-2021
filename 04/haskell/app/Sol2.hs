{-# LANGUAGE NamedFieldPuns #-}
module Main where

import Data.Foldable (foldMap)
import Data.Monoid (Sum (..))

import Debug.Trace

main :: IO ()
main = do
  state <- parse <$> getContents
  let (callout, board) = findLast state
  print $ callout * unmarkedTotal board

type Board = [[Maybe Int]]
data State = State { callouts :: [Int], boards :: [Board] }
  deriving (Show)

unmarkedTotal :: Board -> Int
unmarkedTotal = getSum . (foldMap . foldMap . foldMap) Sum

winning :: Board -> Bool
winning board = or $ [horiz, vert 0, vert 1, vert 2, vert 3, vert 4] <*> pure board
  where
    horiz board = or $ all (== Nothing) <$> board
    vert i board = all (\row -> (row !! i) == Nothing) board

mark :: Int -> Board -> Board
mark callout = (map . map) (\x -> if x == Just callout then Nothing else x)

findLast :: State -> (Int, Board)
findLast State { callouts = [] } = error "No winning board found."
findLast State { callouts = (callout:rest), boards } =
  let marked = map (mark callout) boards
  in
  case filter (not . winning) marked of
    [] -> (callout, mark callout $ head $ filter (not . winning) boards)
    _ -> findLast $ State { callouts = rest, boards = marked }

chunks :: Int -> [a] -> [[a]]
chunks n [] = []
chunks n xs = take n xs : chunks n (drop n xs)

parse :: String -> State
parse src =
  let (calloutLine:boardLines) = lines src
      callouts = map read $ words $ map (\c -> if c == ',' then ' ' else c) calloutLine

      boardLineGroups :: [[String]]
      boardLineGroups = map tail $ chunks 6 $ boardLines

      boards :: [Board]
      boards = (map . map) (map (Just . read) . filter (not . null) . words) boardLineGroups
  in
  State { callouts, boards }
