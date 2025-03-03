module Main where

import Development.Shake

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles = "_generated"} $ do
  phony "clean" $ do
    putInfo "Hello Shake"
