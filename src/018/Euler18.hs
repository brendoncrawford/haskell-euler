--
-- Project Euler
--
-- Problem #18
-- Maximum path sum I
--
-- By starting at the top of the triangle below and
-- moving to adjacent numbers on the row below, the
-- maximum total from top to bottom is 23.
--
--      3
--     7 4
--    2 4 6
--   8 5 9 3
--
-- That is, 3 + 7 + 4 + 9 = 23.
--
-- Find the maximum total from top to bottom of
-- the triangle below:
--
--                 75
--                95 64
--               17 47 82
--              18 35 87 10
--             20 04 82 47 65
--            19 01 23 75 03 34
--           88 02 77 73 07 63 67
--          99 65 04 28 06 16 70 92
--         41 41 26 56 83 40 80 70 33
--        41 48 72 33 47 32 37 16 94 29
--       53 71 44 65 25 43 91 52 97 51 14
--      70 11 33 28 77 73 17 78 39 68 17 57
--     91 71 52 38 17 14 91 43 58 50 27 29 48
--    63 66 04 68 89 53 67 30 73 16 69 87 40 31
--   04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
--
-- NOTE: As there are only 16384 routes, it is
-- possible to solve this problem by trying every route.
-- However, Problem 67, is the same challenge with a
-- triangle containing one-hundred rows; it cannot
-- be solved by brute force, and requires a
-- clever method! ;o)
--
-- Answer: 1074
--


module Main (
  solve,
  main
) where


import Data.List


--
-- Initial sums for each row
--
merg :: [Int] -> [Int] -> [[Int]]
merg x y = out
  where
    pair = zip x [0..]
    out = map build pair
    build (v, i) = take 2 $ adder v i
    adder v i = map (+v) (drop i y)


--
-- Builds pairs for each row
--
builder :: [[Int]] -> [[Int]]
builder m = out
  where
    out = map (map fst) g
    ln = length m
    s = zip (concat m) [0..]
    g = groupBy b s
    b (v1, i1) (v2, i2) 
      | (i1 == 0) = False
      | (v2 == (ln - 1)) = False
      | otherwise = (i2 `mod` 2 == 0)
 

--
-- Finds the max from each collision pair
--
maxxes :: [[Int]] -> [Int]
maxxes b = map maximum b


--
-- Scans through all rows
--
construct :: [[Int]] -> [Int]
construct d = out
  where
    out = foldl1 b d
    b x y = maxxes $ builder $ merg x y


--
-- Gets max from final row
--
getFinal :: [[Int]] -> Int
getFinal d = out
  where
    finals = construct d
    out = maximum finals


--
-- Solver Entry Point
--
solve :: Int
solve = getFinal dta


--
-- Returns Input Data List
--
dta :: [[Int]]
dta =
  [[75],
   [95, 64],
   [17, 47, 82],
   [18, 35, 87, 10],
   [20, 04, 82, 47, 65],
   [19, 01, 23, 75, 03, 34],
   [88, 02, 77, 73, 07, 63, 67],
   [99, 65, 04, 28, 06, 16, 70, 92],
   [41, 41, 26, 56, 83, 40, 80, 70, 33],
   [41, 48, 72, 33, 47, 32, 37, 16, 94, 29],
   [53, 71, 44, 65, 25, 43, 91, 52, 97, 51, 14],
   [70, 11, 33, 28, 77, 73, 17, 78, 39, 68, 17, 57],
   [91, 71, 52, 38, 17, 14, 91, 43, 58, 50, 27, 29, 48],
   [63, 66, 04, 68, 89, 53, 67, 30, 73, 16, 69, 87, 40, 31],
   [04, 62, 98, 27, 23, 09, 70, 98, 73, 93, 38, 53, 60, 04, 23]]


--
-- Main
--
main :: IO ()
main = do
  print solve;


