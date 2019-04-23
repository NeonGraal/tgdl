-- | The TGDL Processor
module TGDL.Processor
  ( main
  ) where

import Diagrams.Backend.Rasterific.CmdLine
import Diagrams.Prelude

import TGDL.Diagram
import TGDL.Parser

fromFile :: FilePath -> IO (Diagram B)
fromFile f = do
  fileContents <- readFile f
  case parseTGDL f fileContents () of
    (Right d, _) -> return $ layoutCircle d
    (Left e, _) -> error $ show e

-- | TGDL Processor main function
main :: IO ()
main = mainWith fromFile
