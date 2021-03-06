module ParserSpec
  ( spec
  ) where

import TGDL.AST
import TGDL.Parser
import Test.Tasty.Hspec

type ParseResult a = ([AST a], String)

resultIs :: (Show a, Eq a) => TGDLParseResult a -> ParseResult a -> Expectation
resultIs (Right t, c) r = (t, c) `shouldBe` r
resultIs (Left e, _) _ = expectationFailure $ show e

parseIt :: String -> ParseResult () -> Spec
parseIt t r = it parseDesc $ parseTGDL parseDesc t () `resultIs` r
  where
    parseDesc = "parse " ++ show t

spec :: Spec
spec = do
  parseIt ".node" ([node "node" ()], "node")
  parseIt "-node2" ([edge "" "node2" ()], "")
  parseIt "- node2" ([edge "" "node2" ()], "")
  parseIt ".node1-node2" ([node "node1" (), edge "node1" "node2" ()], "node1")
  parseIt ".node1 - node2" ([node "node1" (), edge "node1" "node2" ()], "node1")
  parseIt "node1-node2" ([edge "node1" "node2" ()], "node1")
  parseIt "node1 - node2" ([edge "node1" "node2" ()], "node1")
  parseIt ".node1\n.node2" ([node "node1" (), node "node2" ()], "node2")
  parseIt ".node1\n-node2" ([node "node1" (), edge "node1" "node2" ()], "node1")
  parseIt
    ".node1\n-node2\n-node3"
    ( [node "node1" (), edge "node1" "node2" (), edge "node1" "node3" ()]
    , "node1")
