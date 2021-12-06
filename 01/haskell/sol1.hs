main = interact $ show . length . filter id . (zipWith (<) <*> tail) . map ((+0) . read) . words
