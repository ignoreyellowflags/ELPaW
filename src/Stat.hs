module Stat where

import Data.List (sort)
--  | Just rounding value to 3 digit after point
round3dp :: (Fractional a, RealFrac r) => r -> a
round3dp x = fromIntegral (round $ x * 1e3) / 1e3
--  | Mean (statisticks)
mean :: (Floating a) => [a] -> a
mean xs = sum xs / (fromIntegral . length) xs
-- | Var (statisticks)
var :: (Floating a) => [a] -> a
var xs = (sum $ map (\x -> (x - m)^2) xs) / (fromIntegral (length xs)-1)
    where
      m = mean xs
-- | Variance normalized vector (influence variance)
var' :: (Floating a, Ord a) => [a] -> a
var' xs = var $ normalize xs
-- | Normalize vector
normalize :: (Fractional a, Ord a) => [a] -> [a]
normalize xs = map (\x -> (x - minVal)/(maxVal - minVal)) xs
  where
    minVal = foldr min 0 xs
    maxVal = foldr max 0 xs

--  | Median (statisticks). Value separating the higher half from the lower half of a data sample. 
median :: (Floating a, Ord a) => [a] -> a
median x | odd n  = head  $ drop (n `div` 2) x'
         | even n = mean $ take 2 $ drop i x'
                  where i = (length x' `div` 2) - 1
                        x' = sort x
                        n  = length x

