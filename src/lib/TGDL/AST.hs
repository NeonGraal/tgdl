module TGDL.AST (node, edge, AST, nodeName) where

data AST a = Node String a
    | Edge String String a
    deriving (Show, Eq)

node :: String -> a -> AST a
node n a = Node n a

edge :: String -> String -> a -> AST a
edge n1 n2 a = Edge n1 n2 a

nodeName :: AST a -> String
nodeName (Node name _)  = name
nodeName _              = error "Not a Node"
