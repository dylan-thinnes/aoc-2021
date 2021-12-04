module Main where

import Data.List (transpose)

main :: IO ()
main = interact (show . top . parse)

top :: [[Bool]] -> Int
top xss = bitsToInt (oxygen (transpose xss)) * bitsToInt (co2 (transpose xss))

-- Ratings for oxygen, co2
oxygen, co2 :: [[Bool]] -> [Bool]
oxygen = rate id
co2 = rate not

dominantBit :: [Bool] -> Bool
dominantBit bv = length (filter id bv) >= length (filter not bv)

rate :: (Bool -> Bool) -> [[Bool]] -> [Bool]
rate mod [] = []
rate mod xss@(topLayer:_)
  | length topLayer == 1 = map head xss
  | otherwise =
    let d = mod $ dominantBit topLayer
        subset = transpose [tail | head:tail <- transpose xss, head == d ]
    in
    d : rate mod subset

-- Parse & Print
parse :: String -> [[Bool]]
parse = (map . map) ('1' ==) . lines

bitsToInt :: [Bool] -> Int
bitsToInt = foldl (\b a -> b * 2 + fromEnum a) 0
