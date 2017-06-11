{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll

main :: IO ()
main = hakyll $ do
  match "img/*" $ do
    route   idRoute
    compile copyFileCompiler

  match "css/*" $ do
    route   idRoute
    compile compressCssCompiler

  match "*.markdown" $ do
    -- Hack to get pretty URLs without ".html"
    route $ gsubRoute ".markdown" (const "/index.html")
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match "index.html" $ do
    route idRoute
    compile $ pandocCompiler
      >>= loadAndApplyTemplate "templates/default.html" defaultContext
      >>= relativizeUrls

  match "templates/*" $ compile templateBodyCompiler
