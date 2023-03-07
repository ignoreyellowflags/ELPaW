module Gbuild where
import Data.Array
import qualified Data.Map as Map

data NodeW a = NodeW
  { nid :: Integer
  , label :: a
  , nb :: Map.Map Integer Double
  } deriving (Show,Ord,Eq)

getfirst :: (t, t1, t2) -> t
getfirst  (a,_,_) = a

getsecond :: (t, t1, t2) -> t1
getsecond (_,a,_) = a

getthird :: (t, t1, t2) -> t2
getthird  (_,_,a) = a 

getNode g nid = (!) g nid

getNeighbors g nid = map (\x -> getNode g x) neighbors
  where
    neighbors = Map.keys . nb $ getNode g nid

graphBuild xs = array (1,l) ([ (getfirst i, NodeW (getfirst i) (getsecond i) (getthird i) ) | i <- xs] )
  where
    l = fromIntegral $ length xs

