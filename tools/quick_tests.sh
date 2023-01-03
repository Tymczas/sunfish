#!/bin/bash
set -e -u -o pipefail
# Run with `py command` or `py command --debug`
TOOLS=$(dirname "$0")
echo "$TOOLS"
T="python3 $TOOLS/tester.py"

echo "Mate in 1..."
$T "$1" ${2:-"--quiet"} mate $TOOLS/test_files/mate1.fen --depth 2
echo

# Stockfish finds this at around depth 14 with normal search, but faster
# if using "go mate". Currently it's too deep for sunfish to find.
# $T "$1" ${2:-"--quiet"} mate $TOOLS/test_files/nullmove_mates.fen --depth 12

# These mates should be findable at depth=4, but because of null-move
# We need to go to depth=6.
echo "Mate in 2..."
$T "$1" ${2:-"--quiet"} mate $TOOLS/test_files/mate2.fen --depth 4 --quick --limit 20
echo

echo "Stalemate in 0..."
$T "$1" ${2:-"--quiet"} draw $TOOLS/test_files/stalemate0.fen --depth 1
echo

echo "Stalemate in 1..."
$T "$1" ${2:-"--quiet"} draw $TOOLS/test_files/stalemate1.fen --depth 6
echo

echo "Stalemate in 2+"
$T "$1" ${2:-"--quiet"} draw $TOOLS/test_files/stalemate2.fen --depth 4
#echo "(Should be about 85/130)"
echo

echo "Other puzzles..."
$T "$1" ${2:-"--quiet"} best $TOOLS/test_files/win_at_chess_test.epd --ms 100
echo