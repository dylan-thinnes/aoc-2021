module Main where

import Data.List (transpose)

main :: IO ()
main = interact (show . top . parse)

top :: [[Bool]] -> Int
top xss = bvToInt (oxygen (transpose xss)) * bvToInt (co2 (transpose xss))

-- Ratings for oxygen, co2
oxygen, co2 :: [[Bool]] -> [Bool]
oxygen = rate id
co2 = rate not

dominantBit :: [Bool] -> Bool
dominantBit bv = 0.5 <= fromIntegral (length (filter id bv)) / fromIntegral (length bv)

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

bvToInt :: [Bool] -> Int
bvToInt bv = sum $ zipWith (\n b -> fromEnum b * 2 ^ n) [0..] (reverse bv)
