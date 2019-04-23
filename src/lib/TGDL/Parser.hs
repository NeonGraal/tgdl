{-# LANGUAGE TypeFamilies #-}

module TGDL.Parser
  ( parseTGDL
  , TGDLParseResult
  ) where

import TGDL.AST

import Control.Monad
import Control.Monad.State
import Data.Void
import Text.Megaparsec hiding (State)
import Text.Megaparsec.Char

type TGDLState = String

type TGDLParser = ParsecT Void String (State TGDLState)

type TGDLParseResult a = (Either (ParseErrorBundle String Void) [AST a], String)

parseTGDL :: String -> String -> a -> TGDLParseResult a
parseTGDL f s a = flip runState "" $ runParserT (parseDoc a) f s

parseDoc :: a -> TGDLParser [AST a]
parseDoc a = many $ parseAst a

spaceTab :: (MonadParsec e s m, Token s ~ Char) => m (Token s)
spaceTab = separatorChar <|> tab

skipWs :: ParsecT Void String (State TGDLState) ()
skipWs = void $ many spaceTab

skipNl :: ParsecT Void String (State TGDLState) ()
skipNl = void $ many (spaceTab <|> newline)

parseIdent :: ParsecT Void String (State TGDLState) String
parseIdent = do
  ident <- some alphaNumChar
  skipWs
  return ident

parseAst :: a -> TGDLParser (AST a)
parseAst a = parseNode a <|> parseEdge a

parseNode :: a -> TGDLParser (AST a)
parseNode a = do
  void $ char '.'
  name <- parseIdent
  skipNl
  put name
  return $ node name a

parseEdge :: a -> TGDLParser (AST a)
parseEdge a = parseWhole <|> parseCurrent
  where
    parseEnd :: TGDLParser String
    parseEnd = do
      void $ char '-'
      skipWs
      parseIdent
    parseWhole = do
      n <- parseIdent
      e <- parseEnd
      skipNl
      put n
      return $ edge n e a
    parseCurrent = do
      e <- parseEnd
      n <- get
      skipNl
      return $ edge n e a
