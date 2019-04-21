-- | The TGDL Processor
module TGDL.Processor (main) where

import Diagrams.Prelude
import Diagrams.Backend.Rasterific.CmdLine

fromFile :: FilePath -> IO (Diagram B)
fromFile f = return $ text f <> ellipseXY 10 2 # lw 0.1

-- | TGDL Processor main function
main :: IO ()
main = mainWith fromFile
