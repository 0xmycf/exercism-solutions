{-# LANGUAGE OverloadedStrings #-}
module Acronym (abbreviate) where

import           Data.Bifunctor (Bifunctor(first))
import           Data.Char      (isUpper, isLetter)
import           Data.Text      (Text)
import qualified Data.Text      as T

abbreviate :: Text -> Text
abbreviate = T.intercalate "" . everything
  where
    splitted x = T.splitOn " " x >>= T.splitOn "-"
    filteredLetters = fmap $ T.filter Data.Char.isLetter
    mapped = fmap mapper
    mapper thing
      | T.all isUpper thing = T.take 1 thing
      | otherwise =
        let (hd, tl) = maybe ("", "") (first T.singleton) (T.uncons thing)
        in T.toUpper hd <> T.filter isUpper tl
    everything = mapped . filteredLetters . splitted
