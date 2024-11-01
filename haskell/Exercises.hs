module Exercises
    ( change,
      firstThenApply,
      powers,
      meaningfulLineCount,
      Shape(..),
      volume,
      surfaceArea,
      BST(..),
      insert,
      contains,
      size,
      inorder
    ) where

import qualified Data.Map as Map
import Data.Text (pack, unpack, replace)
import Data.List(isPrefixOf, find)
import Data.Char(isSpace)

change :: Integer -> Either String (Map.Map Integer Integer)
change amount
    | amount < 0 = Left "amount cannot be negative"
    | otherwise = Right $ changeHelper [25, 10, 5, 1] amount Map.empty
        where
          changeHelper [] remaining counts = counts
          changeHelper (d:ds) remaining counts =
            changeHelper ds newRemaining newCounts
              where
                (count, newRemaining) = remaining `divMod` d
                newCounts = Map.insert d count counts

-- Write your first then apply function here
firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs predicate func =
    case find predicate xs of
      Just x -> Just (func x)
      Nothing -> Nothing

-- Write your infinite powers generator here
powers :: Integer -> [Integer]
powers base = iterate (* base) 1

-- Write your line count function here
meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount filename = do
    contents <- readFile filename
    return $ length $ filter isMeaningfulLine (lines contents)
  where
    isMeaningfulLine line = not (null (trim line)) && not ("#" `isPrefixOf` trim line)
    trim = f . f
      where f = reverse . dropWhile isSpace

-- Write your shape data type here
data Shape = Sphere Double | Box Double Double Double
    deriving (Eq)
volume :: Shape -> Double
volume (Sphere r) = (4 / 3) * pi * (r ^ 3)
volume (Box w l d) = w * l * d
surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * (r ^ 2)
surfaceArea (Box w l d) = 2 * (w * l + w * d + l * d)
instance Show Shape where
    show (Sphere r) = "Sphere " ++ show r
    show (Box w l d) = "Box " ++ show w ++ " " ++ show l ++ " " ++ show d

-- Write your binary search tree algebraic type here
data BST a = Empty | Node a (BST a) (BST a) deriving (Eq)
insert :: Ord a => a -> BST a -> BST a
insert x Empty = Node x Empty Empty
insert x (Node y left right)
    | x < y     = Node y (insert x left) right
    | x > y     = Node y left (insert x right)
    | otherwise = Node y left right
contains :: Ord a => a -> BST a -> Bool
contains x Empty = False
contains x (Node y left right)
    | x == y    = True
    | x < y     = contains x left
    | otherwise = contains x right
size :: BST a -> Int
size Empty = 0
size (Node _ left right) = 1 + size left + size right
inorder :: BST a -> [a]
inorder Empty = []
inorder (Node x left right) = inorder left ++ [x] ++ inorder right
instance Show a => Show (BST a) where
    show Empty = "()"
    show (Node x Empty Empty) = "(" ++ show x ++ ")"
    show (Node x left Empty) = "(" ++ show left ++ show x ++ ")"
    show (Node x Empty right) = "(" ++ show x ++ show right ++ ")"
    show (Node x left right) = "(" ++ show left ++ show x ++ show right ++ ")"