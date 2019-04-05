module ParserTests (parserSpec) where

import Test.Tasty.Hspec
import TGDL.Parser
import TGDL.AST

resultIs :: (Show a, Eq a) => TGDLResult a -> ([AST a], String) -> Expectation
resultIs (Right t, c) r = (t, c) `shouldBe` r
resultIs (Left e, _) _ = expectationFailure $ show e


parserSpec :: Spec
parserSpec = do
    it ".node parses" $ 
        parseTGDL "test" ".node" () `resultIs`
            ([node "node" ()], "node")
    it "-node parses" $
        parseTGDL "test" "-node2" () `resultIs`
            ([edge "" "node2" ()], "")
    it ".node1-node2 parses" $
        parseTGDL "test" ".node1-node2" () `resultIs`
            ([node "node1" (), edge "node1" "node2" ()], "node1")
    it "node1-node2 parses" $
        parseTGDL "test" "node1-node2" () `resultIs`
            ([edge "node1" "node2" ()], "node1")
    