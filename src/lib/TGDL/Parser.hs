module TGDL.Parser (parseTGDL, TGDLResult) where

import TGDL.AST

import Control.Monad
import Control.Monad.State
import Data.Void
import Text.Megaparsec hiding (State)
import Text.Megaparsec.Char

type TGDLState = String

type TGDLParser = ParsecT Void String (State TGDLState)

type TGDLResult a = (Either (ParseErrorBundle String Void) [AST a], String)

parseTGDL :: String -> String -> a -> TGDLResult a
parseTGDL f s a = flip runState "" $ runParserT (parseDoc a) f s

parseDoc :: a -> TGDLParser [AST a]
parseDoc a = many $ parseNode a
    <|> parseEdge a


parseNode :: a -> TGDLParser (AST a)
parseNode a = do
    void $ char '.'
    name <- some alphaNumChar
    put name
    return $ node name a

parseEdge :: a -> TGDLParser (AST a)
parseEdge a = parseWhole <|>
    parseCurrent
    where 
        parseEnd :: TGDLParser String
        parseEnd = do
            void $ char '-'
            some alphaNumChar
        parseWhole = do
            n <- some alphaNumChar
            e <- parseEnd
            put n
            return $ edge n e a
        parseCurrent = do
            e <- parseEnd
            n <- get
            return $ edge n e a
