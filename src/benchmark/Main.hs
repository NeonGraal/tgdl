-- You can benchmark your code quickly and effectively with Criterion. See its
-- website for help: <http://www.serpentine.com/criterion/>.
import TGDL.Parser

import Criterion.Types
import Criterion.Main

parseBench :: String -> Benchmark
parseBench t = bench benchDescr $ whnf benchParse ()
    where
        benchDescr = "parse '" ++ t ++ "'"
        benchParse = parseTGDL benchDescr t

main :: IO ()
main = defaultMainWith config [bgroup "Parsing" [parseBench t | t <- parseBenchmarks]]
    where
        config = defaultConfig { timeLimit = 2 }
        parseBenchmarks = [".node1", "-node2", ".node1-node2", "node1-node2"]
