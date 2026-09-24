# HS Biology — practical simulations

Self-contained HTML simulations for the HS Biology course, hosted so TimeBack can embed them.

Each file is **one page with no external request of any kind** — no CDN, no fonts, no images
fetched at runtime. Artwork is inline SVG and any photograph is embedded as a data URI. That
matters: a strict frame policy blocks external requests silently, so a simulation that fetched
anything would fail without an error.

## Embedding

```html
<iframe src="https://USER.github.io/hs-bio-sims/enzyme-temperature/collect-results.html"
        width="100%" height="1000" title="Collect the results"></iframe>
```

Each page posts the height it needs to its parent whenever its layout changes:

```js
window.addEventListener("message", function (e) {
  if (e.data && e.data.type === "sim-height") { /* set that frame's height */ }
});
```

Act on that and the frame fits exactly. Ignore it and the `height` attribute above is the
fallback — it will simply be a little too tall or too short.

## What is here

| Practical | Pages |
|---|---|
| Enzymes and temperature | equipment set-up, collect results, plot the graph, eight questions |
| Osmosis: potato and sugar solution | collect results, plot the graph |

## These files are generated

Do not edit them here. They are built from the course source by scripts in each unit's
`_tools/` folder — `build_setup_sim.py`, `build_osmosis_collect.py`, `build_osmosis_plot.py`,
`build_mcqs.py` and the shared `sim_theme.py`. Edit the builder or the data module, rebuild, and
copy the result in with `./sync.sh`.

The data a simulation uses is deliberately fixed, not modelled: a marked question needs one right
answer, so every student gets the same readings.
