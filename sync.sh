#!/bin/bash
# Re-copy the built simulations out of the course folders. Run after rebuilding any of them.
set -e
SRC="/Users/danboorman/Library/CloudStorage/GoogleDrive-dan.boorman@alpha.school/.shortcut-targets-by-id/1MnpUfejpG-ZKkb-3ULy9UcTdICXBVFqy/Science AP/Biology/HS Biology from Timeback"
HERE="$(cd "$(dirname "$0")" && pwd)"
cp "$SRC/Unit 1 Rebuild/sims/bio1-260_equipment-setup.html"     "$HERE/enzyme-temperature/equipment-setup.html"
cp "$SRC/Unit 1 Rebuild/sims/bio1-260_enzyme-temperature.html"  "$HERE/enzyme-temperature/collect-results.html"
cp "$SRC/Unit 1 Rebuild/sims/bio1-260_plot-the-graph.html"      "$HERE/enzyme-temperature/plot-the-graph.html"
cp "$SRC/Unit 1 Rebuild/sims/bio1-260_practical-questions.html" "$HERE/enzyme-temperature/questions.html"
cp "$SRC/Unit 2 Rebuild/sims/bio2-210_equipment-setup.html"     "$HERE/osmosis-potato/equipment-setup.html"
cp "$SRC/Unit 2 Rebuild/sims/bio2-210_practical-questions.html" "$HERE/osmosis-potato/questions.html"
cp "$SRC/Unit 2 Rebuild/sims/bio2-210_osmosis-collect.html"     "$HERE/osmosis-potato/collect-results.html"
cp "$SRC/Unit 2 Rebuild/sims/bio2-210_osmosis-plot.html"        "$HERE/osmosis-potato/plot-the-graph.html"
echo "synced $(find "$HERE" -name '*.html' | wc -l | tr -d ' ') pages"
