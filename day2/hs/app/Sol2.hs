{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Control.Lens
import Control.Lens.TH
import Data.Monoid

data Submarine = Submarine { _distance :: Int, _depth :: Int, _aim :: Int }
  deriving (Show)
makeLenses ''Submarine

data Command = Unrecognized | Down Int | Up Int | Forward Int

parse :: [String] -> Command
parse ["forward", val] = Forward $ read val
parse ["up", val]      = Up $ read val
parse ["down", val]    = Down $ read val
parse _                = Unrecognized

start :: Submarine
start = Submarine { _distance = 0, _depth = 0, _aim = 0 }

run :: Command -> Submarine -> Submarine
run (Forward v)  sub = sub & distance +~ v & depth +~ sub ^. aim * v
run (Up v)       sub = sub & aim -~ v
run (Down v)     sub = sub & aim +~ v
run Unrecognized sub = sub

summary :: Submarine -> String
summary sub = unlines [show sub, show (sub ^. depth * sub ^. distance)]

main :: IO ()
main = interact $ summary . foldr (run . parse) start . reverse . map words . lines
