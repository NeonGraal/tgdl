{-# LANGUAGE FlexibleContexts #-}

module TGDL.Diagram
  ( layoutCircle
  ) where

import Data.List (nub)

import Diagrams.Backend.Rasterific.CmdLine
import Diagrams.Prelude

import TGDL.AST

layoutCircle :: [AST a] -> Diagram B
layoutCircle doc = doNodes # doArrows
  where
    doNodes =
      atPoints
        (trailVertices $ regPoly (length docNodes) 10)
        (map nodeEllipse docNodes)
    doArrows = applyAll [connectOutside' arrowOpts s e | [s, e] <- docEdges]
    docNodes = nub $ concatMap astNodes doc
    docEdges = map astNodes $ filter isEdge doc
    nodeEllipse n = text n # fontSizeL 1 <> ellipseXY 4 1 # lw 0.1 # named n
    arrowOpts =
      with & gaps .~ small & headLength .~ local 0.15 & shaftStyle %~ lw 0.1
