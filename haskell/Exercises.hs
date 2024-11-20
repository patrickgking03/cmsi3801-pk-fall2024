module Exercises
    ( change,
      firstThenApply,
      powers,
      meaningfulLineCount,
      Shape(..),
      BST(Empty),
      volume,
      surfaceArea,
      size,
      contains,
      insert,
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

firstThenApply :: [a] -> (a -> Bool) -> (a -> b) -> Maybe b
firstThenApply xs p f = f <$> find p xs

powers :: Integral a => a -> [a]
powers base = map (base^) [0..]

meaningfulLineCount :: FilePath -> IO Int
meaningfulLineCount filePath = do
    document <- readFile filePath
    let allWiteSpace = all isSpace
        trimStart = dropWhile isSpace
        isMeaningful line = 
            not (allWiteSpace line) &&
            not ("#" `isPrefixOf` (trimStart line))
    return $ length $ filter isMeaningful $ lines document

data Shape
    = Sphere Double
    | Box Double Double Double
    deriving (Eq, Show)

volume :: Shape -> Double
volume (Sphere r) = (4 / 3) * pi * (r ^ 3)
volume (Box w l d) = w * l * d

surfaceArea :: Shape -> Double
surfaceArea (Sphere r) = 4 * pi * (r ^ 2)
surfaceArea (Box w l d) = 2 * ((w * l) + (w * d) + (l * d))

data BST a = Empty | Node a (BST a) (BST a)

insert :: Ord a => a -> BST a -> BST a
insert x Empty = Node x Empty Empty
insert x (Node y left right)
    | x < y = Node y (insert x left) right
    | x > y = Node y left (insert x right)
    | otherwise = Node y left right

contains :: Ord a => a -> BST a -> Bool
contains _ Empty = False
contains x (Node y left right)
    | x < y = contains x left
    | x > y = contains x right
    | otherwise = True

size :: BST a -> Int
size Empty = 0
size (Node _ left right) = 1 + size left + size right

inorder :: BST a -> [a]
inorder Empty = []
inorder (Node x left right) = inorder left ++ [x] ++ inorder right

instance (Show a) => Show (BST a) where
    show :: Show a => BST a -> String
    show Empty = "()"
    show (Node x left right) =
        let full = "(" ++ show left ++ show x ++ show right ++ ")" in
        unpack $ replace (pack "()") (pack "") (pack full)