main = interact $ show . length . filter id . (zipWith (<) <*> tail . tail . tail) . map ((+0) . read) . words
