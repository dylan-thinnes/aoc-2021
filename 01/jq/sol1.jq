#!/usr/bin/env -S jq -s -f
[.[1:], .[:-1]] | transpose | [.[] | select(.[0] > .[1])] | length
