module DST where

import qualified Data.Set as Set
import qualified Data.Map as Map

--DST
--powerset :: Ord a => Set a -> Set (Set a)
maybeval :: Num t => Maybe t -> t
maybeval x = case x of
  Just x' -> x'
  Nothing -> 0

powerset s
  | s == Set.empty = Set.singleton Set.empty
  | otherwise      = Set.map (Set.insert x) pxs `Set.union` pxs
    where (x,xs)   = Set.deleteFindMin s
          pxs      = powerset xs

--belief :: (Num a, Ord k) => Set k -> Map (Set k) a -> a
belief evidence mass = sum $ Prelude.map (\x -> maybeval $ Map.lookup x mass) allsubsets
  where
    allsubsets = Set.toList $ powerset evidence

--plausibility :: (Num a, Ord k) => Set k -> Set (Set k) -> Map (Set k) a -> a
plausibility evidence pwset mass = sum $ Prelude.map (\x -> maybeval $ Map.lookup x mass) allsubsets
  where
    allsubsets = Set.toList $ Set.filter (not . Set.null . Set.intersection evidence) pwset

plausibility' evidence mass = sum $ Prelude.map (\x -> maybeval $ Map.lookup x mass) allsubsets
  where
    allsubsets = Set.toList $ Set.filter (not . Set.null . Set.intersection evidence) $ (Set.fromList $ Map.keys mass)  

--jointfocal :: (Num b, Ord a) => (Set a, b) -> (Set a, b) -> (Set a, b)
jointfocal el el' = (iset,value)
  where
    iset  = fst el `Set.intersection` fst el'
    value = snd el * snd el'

--combrule :: (Num a, Ord k) => Map (Set k) a -> Map (Set k) a -> Map (Set k) a
combrule a b = Map.fromListWith (+) $ jointfocal <$> Map.assocs a <*> Map.assocs b

--normfactor :: (Fractional b, Ord a) => Map (Set a) b -> Map (Set a) b
normfactor a = Map.map (/(1-k) ) a
  where
    k = maybeval $ Map.lookup (Set.empty) a
