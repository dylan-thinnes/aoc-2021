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
  bitsToInt bv * bitsToInt (not <$> bv)

bitsToInt :: [Bool] -> Int
bitsToInt = foldl (\b a -> b * 2 + fromEnum a) 0

dominantBits :: [[Bool]] -> [Bool]
dominantBits bvs =
  [ length (filter id bv) > length bv `div` 2
  | bv <- transpose bvs
  ]
