module Main (main) where

import System.Environment
import Text.CSV
import Data.Array
import qualified Data.Map as Map
import Data.List.Split (splitOn)
import Lib
import Gbuild


main = do
  args <- getArgs
  let fileName    = head args
  let fileNameOut = last args
  let ratingFile  = args !! 1
  input <- readFile fileName
  let csv     = parseCSV fileName input
  let parsed  = either handleError doWork csv
  
  let adjList = map adjacenceRecW $ filter ((==3) . length) $ tail parsed

  let g     = graphBuild adjList
  let order = updateOrder g
  let g1    = endofUpdate g (map fst order)
  writeFile fileNameOut $ unlines $ map show (elems g1)
  --print(order)
  writeFile ratingFile $ unlines $ map show order
  print("ok")

handleError csv = [[""]]
doWork csv      = csv

nodeWeight xs = (nid, ie)
  where
    nid = read $ head xs :: Integer
    ie  = read $ last xs :: Double

adjacenceRecW rec = (recid, reclabel, recnid)
  where
    recid    = read $ head rec :: Integer
    reclabel = (!!) rec 1
    recnid   = Map.fromList  $ map (\x -> nodeWeight $ splitOn "/" x ) $ splitOn "|" (last rec)
