module TGDL.AST
  ( node
  , edge
  , AST
  , nodeName
  , astNodes
  , isEdge
  ) where

data AST a
  = Node String
         a
  | Edge String
         String
         a
  deriving (Show, Eq)

node :: String -> a -> AST a
node = Node

edge :: String -> String -> a -> AST a
edge = Edge

nodeName :: AST a -> String
nodeName (Node name _) = name
nodeName _ = error "Not a Node"

astNodes :: AST a -> [String]
astNodes (Node n _) = [n]
astNodes (Edge s e _) = [s, e]

isEdge :: AST a -> Bool
isEdge Edge {} = True
isEdge _ = False
