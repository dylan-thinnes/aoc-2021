{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Control.Lens
import Control.Lens.TH
import Data.Monoid

data Submarine = Submarine { _distance :: Int, _depth :: Int }
  deriving (Show)
makeLenses ''Submarine

data Command = Unrecognized | Down Int | Up Int | Forward Int

parse :: [String] -> Command
parse ["forward", val] = Forward $ read val
parse ["up", val]      = Up $ read val
parse ["down", val]    = Down $ read val
parse _                = Unrecognized

start :: Submarine
start = Submarine { _distance = 0, _depth = 0 }

run :: Command -> Submarine -> Submarine
run (Forward v)  = distance +~ v
run (Up v)       = depth -~ v
run (Down v)     = depth +~ v
run Unrecognized = id

summary :: Submarine -> String
summary sub = unlines [show sub, show (sub ^. depth * sub ^. distance)]

main :: IO ()
main = interact $ summary . foldr (run . parse) start . reverse . map words . lines
