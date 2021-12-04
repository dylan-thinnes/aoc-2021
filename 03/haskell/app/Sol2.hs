module Main where

main :: IO ()
main = interact (show . top . parse)

top :: [[Bool]] -> Int
top xss = bitsToInt (oxygen xss) * bitsToInt (co2 xss)

-- Ratings for oxygen, co2
oxygen, co2 :: [[Bool]] -> [Bool]
oxygen = rate id
co2 = rate not

dominantBit :: [Bool] -> Bool
dominantBit bv = 0 <= sum [if b then 1 else -1 | b <- bv]

rate :: (Bool -> Bool) -> [[Bool]] -> [Bool]
rate _ [] = error "No inputs left!"
rate _ [bv] = bv
rate modifyTarget bvs
  | any null bvs = []
  | otherwise =
    let topLayer = map head bvs
        targetBit = modifyTarget $ dominantBit topLayer
        subset = [tail | head:tail <- bvs, head == targetBit ]
    in
    targetBit : rate modifyTarget subset

-- Parse & Print
parse :: String -> [[Bool]]
parse = (map . map) ('1' ==) . lines

bitsToInt :: [Bool] -> Int
bitsToInt = foldl (\b a -> b * 2 + fromEnum a) 0
