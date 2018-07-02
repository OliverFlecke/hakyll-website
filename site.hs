--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Data.Monoid (mappend)
import Hakyll

import System.FilePath.Posix (takeBaseName, takeDirectory, (</>), replaceExtension)
import Data.List (sortBy, isSuffixOf)
--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    copyFiles ("images/**.png" .&&. complement "images/animations/**.png")
    copyFiles "images/**.gif"
    copyFiles "scripts/*.js"

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "404.html" $ do
        route idRoute
        compile $ do
            getResourceBody

    match "about.md" $ do
        route   $ cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/main.html" defaultContext
            >>= relativizeUrls
            >>= cleanIndexUrls

    match "algorithms/*" $ do
        route $ cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/algorithm.html" postCtx
            >>= loadAndApplyTemplate "templates/main.html" postCtx
            >>= relativizeUrls
            >>= cleanIndexUrls

    match "publications/*" $ do
        route $ cleanRoute
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/publication.html" postCtx
            >>= relativizeUrls
            >>= cleanIndexUrls

    match "index.html" $ do
        route cleanRoute
        compile $ do
            algorithms <- recentFirst =<< loadAll "algorithms/*"
            publications <- recentFirst =<< loadAll "publications/*"

            let index =
                    listField "algorithms" postCtx (return algorithms) `mappend`
                    listField "publications" postCtx (return publications) `mappend`
                    constField "title" "Home" `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate index
                >>= loadAndApplyTemplate "templates/main.html" index
                >>= relativizeUrls
                >>= cleanIndexUrls

    match "templates/*" $ compile templateBodyCompiler

copyFiles :: Pattern -> Rules ()
copyFiles pattern =
    match pattern $ do
        route   idRoute
        compile copyFileCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

-- Functions to clean the routes
cleanRoute :: Routes
cleanRoute = customRoute createIndexRoute
    where
        createIndexRoute ident =
            case baseName of
                "index" -> ((`replaceExtension` "html") . toFilePath) ident
                _       -> takeDirectory p </> takeBaseName p </> "index.html"
            where
                p = toFilePath ident
                baseName = takeBaseName p

cleanIndexUrls :: Item String -> Compiler (Item String)
cleanIndexUrls = return . fmap (withUrls cleanIndex)

cleanIndexHtmls :: Item String -> Compiler (Item String)
cleanIndexHtmls = return . fmap (replaceAll pattern replacement)
    where
        pattern = "/index.html"
        replacement = const "/"

cleanIndex :: String -> String
cleanIndex url
    | idx `isSuffixOf` url = take (length url - length idx) url
    | otherwise            = url
    where idx = "index.html"