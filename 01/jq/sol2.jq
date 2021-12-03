#!/usr/bin/env -S jq -s -f
[.[3:], .[:-3]] | transpose | [.[] | select(.[0] > .[1])] | length
