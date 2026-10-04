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
cp "$SRC/Practicals/conclusions/"*.html                          "$HERE/conclusions/"
cp "$SRC/Practicals/skills/"*.html                               "$HERE/skills/"
cp "$SRC/Practicals/sims/"*.html                                  "$HERE/practicals/"
# ---------------------------------------------------------------------------------------
# AP Biology. Unlike the HS sims, which are served one page at a time to be framed from
# TimeBack, the AP set carries its own lesson pages, so the whole tree is copied under ap/
# and reached through ap/index.html. _tools and _review stay out: they are the source and
# the review scaffolding, not the site.
# ---------------------------------------------------------------------------------------
AP="/Users/danboorman/Library/CloudStorage/GoogleDrive-dan.boorman@alpha.school/.shortcut-targets-by-id/1MnpUfejpG-ZKkb-3ULy9UcTdICXBVFqy/Science AP/Biology/AP Practicals"
rm -rf "$HERE/ap"
mkdir -p "$HERE/ap"
cp "$AP/index.html" "$HERE/ap/"
for d in sims skills conclusions questions; do
    mkdir -p "$HERE/ap/$d"
    cp "$AP/$d/"*.html "$HERE/ap/$d/"
done
for d in "$AP"/*/; do
    name="$(basename "$d")"
    case "$name" in _tools|_review|videos) continue ;; esac
    [ -f "$d/index.html" ] || continue
    mkdir -p "$HERE/ap/$name"
    cp "$d/index.html" "$HERE/ap/$name/"
done
# videos are copied only once they exist; a missing one leaves a waiting card and the
# lesson page still works
mkdir -p "$HERE/ap/videos"
# Parked renders (-ATTEMPT-n, -STUCK-nnh) are kept beside the masters as a record of what
# a prompt change altered. They are not part of the site, so they are not copied.
for v in "$AP/videos/"*.mp4; do
    case "$(basename "$v")" in *-ATTEMPT-*|*-STUCK-*) continue ;; esac
    cp "$v" "$HERE/ap/videos/" 2>/dev/null || true
done

# ---------------------------------------------------------------------------------------
# HS Biology, as whole practicals. The pages above this are individual simulations, served
# one at a time to be framed from TimeBack. These six are the self-contained lesson pages,
# the same shape as the AP set, reached through hs/index.html.
#
# Each HS practical keeps its own videos/ folder beside its page and refers to it as
# videos/x.mp4, so that folder is copied next to the page rather than pooled. The AP set
# pools its videos at the package root and says ../videos/x.mp4; copying one layout into
# the other's shape is what breaks the links.
# ---------------------------------------------------------------------------------------
rm -rf "$HERE/hs"
mkdir -p "$HERE/hs"
cp "$SRC/Practicals/index.html" "$HERE/hs/"
hs_page () {   # <slug> <the self-contained page, relative to SRC>
    local dir
    dir="$(dirname "$SRC/$2")"
    mkdir -p "$HERE/hs/$1"
    cp "$SRC/$2" "$HERE/hs/$1/index.html"
    [ -d "$dir/videos" ] && cp -R "$dir/videos" "$HERE/hs/$1/"
}
hs_page enzyme-temperature       "Unit 1 Rebuild/Practicals/enzyme-temperature/artifact.html"
hs_page osmosis-potato           "Unit 2 Rebuild/Practicals/osmosis-potato/lesson.html"
hs_page photosynthesis-light     "Practicals/photosynthesis-light/lesson.html"
hs_page microscope-magnification "Practicals/microscope-magnification/lesson.html"
hs_page population-quadrats      "Practicals/population-quadrats/lesson.html"
hs_page biodiversity-forests     "Practicals/biodiversity-forests/lesson.html"

echo "synced $(find "$HERE" -name '*.html' | wc -l | tr -d ' ') pages"
