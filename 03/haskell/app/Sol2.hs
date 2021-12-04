{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE OverlappingInstances #-}
module Main where

import Data.List (transpose)
import Debug.Trace

main :: IO ()
main = interact (show . top . parse)

parse :: String -> [[Bool]]
parse = (map . map) ('1' ==) . lines

top :: [[Bool]] -> Int
top xss = bvToInt (oxygen (transpose xss)) * bvToInt (co2 (transpose xss))

bvToInt :: [Bool] -> Int
bvToInt bv = sum $ zipWith (\n b -> fromEnum b * 2 ^ n) [0..] (reverse bv)

dominantBit :: [Bool] -> Bool
dominantBit bv = 0.5 <= fromIntegral (length (filter id bv)) / fromIntegral (length bv)

instance Show [Bool] where
  show bs = map (\x -> if x then '1' else '0') bs

oxygen :: [[Bool]] -> [Bool]
oxygen [] = []
oxygen xss@(topLayer:_)
  | length topLayer == 1 = map head xss
  | otherwise =
      let d = dominantBit topLayer
          subset = transpose [tail | head:tail <- transpose xss, head == d ]
      in
      d : oxygen subset

co2 :: [[Bool]] -> [Bool]
co2 [] = []
co2 xss@(topLayer:_)
  | length topLayer == 1 = map head xss
  | otherwise =
      let d = not $ dominantBit topLayer
          subset = transpose [tail | head:tail <- transpose xss, head == d ]
      in
      d : co2 subset
