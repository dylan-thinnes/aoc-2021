module Main where

import qualified Data.Map as M

data Rule = Rule { start :: Char, end :: Char, between :: Char }
  deriving Show

parse :: String -> Rule
parse (start:end:_:_:_:_:between:[]) = Rule start end between

apply :: [Rule] -> String -> String
apply rules (c0:c1:rest) =
  let matchingRules = [rule | rule <- rules, start rule == c0, end rule == c1 ]
      betweens = map between matchingRules
  in
  c0 : betweens ++ apply rules (c1:rest)
apply rules rest = rest

frequencies :: String -> M.Map Char Int
frequencies = foldr (M.alter (Just . maybe 0 succ)) M.empty

main :: IO ()
main = do
  (starting:_:srcs) <- lines <$> getContents
  let rules = map parse srcs
  let iterations = iterate (apply rules) starting
  let out = iterations !! 10
  let qtys = frequencies out
  putStrLn out
  print qtys
  print $ maximum (M.elems qtys) - minimum (M.elems qtys)
  pure ()
