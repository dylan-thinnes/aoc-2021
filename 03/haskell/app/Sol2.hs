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
dominantBit bv = length (filter id bv) >= length (filter not bv)

rate :: (Bool -> Bool) -> [[Bool]] -> [Bool]
rate mod [] = error "No inputs left!"
rate mod [bv] = bv
rate mod bvs
  | any null bvs = []
  | otherwise =
    let topLayer = map head bvs
        targetBit = mod $ dominantBit topLayer
        subset = [tail | head:tail <- bvs, head == targetBit ]
    in
    targetBit : rate mod subset

-- Parse & Print
parse :: String -> [[Bool]]
parse = (map . map) ('1' ==) . lines

bitsToInt :: [Bool] -> Int
bitsToInt = foldl (\b a -> b * 2 + fromEnum a) 0
