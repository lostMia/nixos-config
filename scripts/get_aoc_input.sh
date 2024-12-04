#/usr/bin/env bash

AOC_COOKIE="53616c7465645f5f941ef7edaf937faefbf7eae768c8ab50e39a9e2e387734b4ae3c5022a8580c7546a5388ae4bf877ab63ed738ee1fed4a6f20bf8680982219"

curl --cookie "session=$AOC_COOKIE" "$(echo `date +https://adventofcode.com/%Y/day/%d/input` | sed 's/\/0/\//g')" > input.txt
