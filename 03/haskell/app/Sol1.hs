module Main where

import Data.List (transpose)

main :: IO ()
main = interact (show . top . parse)

parse :: String -> [[Bool]]
parse = (map . map) ('1' ==) . lines

top :: [[Bool]] -> Int
top xss =
  let bv = dominantBits xss
  in
  bvToInt bv * bvToInt (not <$> bv)

bvToInt :: [Bool] -> Int
bvToInt bv = sum $ zipWith (\n b -> fromEnum b * 2 ^ n) [0..] (reverse bv)

dominantBits :: [[Bool]] -> [Bool]
dominantBits bvs =
  [ length (filter id bv) > length bv `div` 2
  | bv <- transpose bvs
  ]
