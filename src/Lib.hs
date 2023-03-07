module Lib where

import Data.Array
import Data.List (sortOn,sort)
import Gbuild
import Stat
import DST

import qualified Data.Set as Set
import qualified Data.Map as Map

sim u v = case isin of True -> overlap / union * ie
                               where
                                 uset    = Set.fromList $ (nid u) : (Map.keys $ nb u)
                                 vset    = Set.fromList $ (Map.keys $ nb v)
                                 overlap = fromIntegral . Set.size $ uset `Set.intersection` vset
                                 union   = fromIntegral . Set.size $ uset `Set.union` vset
                                 ie      = (nb u) Map.! (nid v)
                       False -> 0
  where isin = (nid v) `elem` (Map.keys $ nb u)

confidence u v = sim u v * (/) vDgr uDgr
  where
    vDgr = fromIntegral $ length (Map.keys $ nb v)
    uDgr = fromIntegral $ length (Map.keys $ nb u)

updateOrder g = reverse . sortOn snd $ map (\i -> (exploreID i, round3dp . var' $ confValues i) ) $ indices g
  where
    exploreID  = \x -> nid $ getNode g x
    confValues = \x -> (confidence) <$> [getNode g x] <*> getNeighbors g x

phi y x = exp ( -y * (1-x)/x )

gammaCalc xs = 1 / ( median $ map (\i -> ( (1-i)/i)^2 ) xs )

confToMass xs = map (\i -> (fst i, phi gamma (snd i) ) ) xs 
  where
    gamma = gammaCalc $ map snd xs
--TEST
-- not good performance | Former `labelAssign`
confArea g ind = map (\i -> (label i, confidence exploreNode i) ) nb
  where
    exploreNode  = getNode g ind
    nb = getNeighbors g ind

plausibilityArea xs = map (\i -> (Set.elems i, plausibility' i massFunc) ) $ Map.keys massFunc
  where
    massFunc = Map.fromListWith (+) $ map (\i -> (Set.fromList [fst i], snd i) ) xs
    --pw    = powerset $ Set.fromList (map fst xs)

labelAssign' xs = head $ fst . last $ sortOn snd xs

epochLabel 0 g _ = g
epochLabel n g (x:xs) = (//) (epochLabel (n-1) g xs) [(x,newNode)]
  where
    newNode = NodeW (nid currentNode) newLabel (nb currentNode)
    currentNode = getNode g x
    newLabel    = labelAssign' . plausibilityArea . confToMass $ confArea g x

epochLabel' g i = (//) g [(i,newNode)]
  where
    newNode = NodeW (nid currentNode) newLabel (nb currentNode)
    currentNode = getNode g i
    newLabel = labelAssign' . plausibilityArea . confToMass $ confArea g i  

graphUpdate g [] = g
graphUpdate g (x:xs) = graphUpdate (epochLabel' g x) xs

--TEST
endofUpdate g [] = g
endofUpdate g ordlist
  | g /= (graphUpdate g ordlist) = endofUpdate (graphUpdate g ordlist) ordlist
  | g == (graphUpdate g ordlist ) = g
