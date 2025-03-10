{-# LANGUAGE DeriveGeneric #-}

module Main where

import Data.Aeson (encode)
import Data.Maybe (fromMaybe)
import Development.Shake
import Development.Shake.FilePath

outDir :: String
outDir = "_generated"

wOutDir :: FilePath -> FilePath
wOutDir x = outDir </> x

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles = outDir} $ do
  phony "clean" $ do
    putInfo "Hello Shake"

  wOutDir "ivy_work_dir.json" %> \out -> do
    env <- getEnv "IVY_WORK_DIR"
    let ivy_work_dir = fromMaybe "ivy_work_dir" env
    writeFileChanged out $ encode ivy_work_dir
