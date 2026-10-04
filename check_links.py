#!/usr/bin/env python3
"""Every relative link in the repo must resolve from the page it sits on.

Written after a whole set of AP video links 404ed: the existence check ran from the package
root and found every file, the browser ran from the page's own folder and found none. The
two layouts in this repo make it easy to repeat -- the HS practicals keep videos beside
their page and say videos/x.mp4, the AP set pools them and says ../videos/x.mp4 -- so the
only safe question is the one the browser asks.

    python3 check_links.py
"""
import os
import re
import sys

ROOT = os.path.dirname(os.path.abspath(__file__))
bad, checked, pages = [], 0, 0

for dirpath, dirs, names in os.walk(ROOT):
    dirs[:] = [d for d in dirs if not d.startswith(".")]
    for name in names:
        if not name.endswith(".html"):
            continue
        pages += 1
        page = os.path.join(dirpath, name)
        html = re.sub(r'srcdoc="(?:[^"\\]|\\.)*"', "", open(page, encoding="utf-8").read())
        for attr in re.findall(r'(?:src|href)="([^"]+)"', html):
            if attr.startswith(("http://", "https://", "#", "data:", "mailto:")):
                continue
            checked += 1
            if not os.path.exists(os.path.normpath(
                    os.path.join(dirpath, attr.split("?")[0]))):
                bad.append(f"{os.path.relpath(page, ROOT)} -> {attr}")

print(f"{pages} pages, {checked} relative links")
if bad:
    print(f"{len(bad)} that do not resolve:")
    for b in bad:
        print("  ", b)
    sys.exit(1)
print("every one resolves")
