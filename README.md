# Single-Cell RNA-seq and TCR-seq for Immunologists

A six-week, hands-on graduate course covering scRNA-seq and paired scTCR-seq analysis, taught side by side in **R (Seurat + scRepertoire)** and **Python (Scanpy + scirpy)**. Built as a [Quarto](https://quarto.org) book and published automatically to GitHub Pages.

**Live site:** https://aezamora14.github.io/scRNA-immunology-course/

## Course outline

| Week | Chapter | Topics |
|---|---|---|
| 1 | From cells to counts | 10x 5′ chemistry, count matrices, QC, doublets |
| 2 | Normalization and PCA | Log-normalization, SCTransform, HVGs, scaling, PCA and loadings |
| 3 | Neighbours, clustering, UMAP | kNN/SNN graphs, Leiden, resolution, UMAP and its limits |
| 4 | Annotation | Markers, cluster DE, Azimuth/CellTypist, T cell subclustering |
| 5 | TCR repertoire | Clonotype definitions, expansion, diversity, clone–phenotype links |
| 6 | Multi-sample and capstone | Integration, pseudobulk DE, composition, clonotype tracking |

Plus appendices: setup, glossary, further reading.

## Publish to your GitHub Pages (one-time setup)

Requires [Quarto](https://quarto.org/docs/get-started/) (optional, for local preview), git, and the [GitHub CLI](https://cli.github.com) logged in (`gh auth login`).

```bash
cd scRNA-immunology-course
bash setup-github.sh aezamora14
```

The script substitutes your username into the config, initialises git, creates the `gh-pages` branch Quarto publishes to, creates the repository, pushes, and turns on Pages. Within a few minutes the site is live at `https://aezamora14.github.io/scRNA-immunology-course/`.

After that, **every push to `main` rebuilds and republishes the site** via `.github/workflows/publish.yml`.

### Manual alternative

If you prefer not to use the script:

1. Confirm `repo-url` in `_quarto.yml` points to your repository (it is set to aezamora14/scRNA-immunology-course).
2. `git init -b main && git add -A && git commit -m "Initial commit"`
3. Create the empty publish branch: `git checkout --orphan gh-pages && git rm -rf . && git commit --allow-empty -m "init" && git checkout main`
4. Create a repository on GitHub, add it as `origin`, then `git push -u origin main && git push origin gh-pages`
5. On GitHub: **Settings → Pages → Source: Deploy from a branch → `gh-pages` / `/ (root)`**
6. **Settings → Actions → General → Workflow permissions → Read and write**
7. The **Actions** tab shows the build; the site appears when it finishes.

## Local preview

```bash
quarto preview
```

## How the code blocks work

Code in the chapters is display-only (```` ```r ```` and ```` ```python ```` fences), so the site builds on GitHub's runners with nothing but Quarto — no R, Python or data needed in CI. Students copy the code into their own sessions, where the data lives.

To switch to executed chapters with rendered plots:

1. Change fences to executable ones (```` ```{r} ```` / ```` ```{python} ````) in the chapters you want executed.
2. In `_quarto.yml`, set `execute: eval: true` and keep `freeze: auto`.
3. Render locally once (`quarto render`) with the data in `data/raw/`; this writes cached outputs to `_freeze/`.
4. Remove `_freeze/` from `.gitignore` and commit it. CI will then reuse the cached outputs without executing code.

## Adapting the course

- **Dataset:** any 10x 5′ Immune Profiling dataset works. Drop the files into `data/raw/` following `appendix/setup.qmd`.
- **Mouse:** change `^MT-` to `^mt-`, use `cc.genes` mouse orthologs, and swap Azimuth's PBMC reference / CellTypist's `Immune_All_Low` for mouse models.
- **One language only:** delete the other tab from each `panel-tabset` block, or leave both; the tabs are harmless.
- **Slides:** each chapter's Concepts section is written to be lifted into slides; `quarto render --to revealjs` on an individual chapter is a reasonable start.

## Repository layout

```
├── _quarto.yml                 # book structure and theme
├── index.qmd                   # landing page
├── chapters/01–06-*.qmd        # weekly sessions
├── appendix/                   # setup, glossary, further reading
├── images/                     # concept figures (SVG)
├── install.R                   # R package installer
├── environment.yml             # conda environment for Python
├── setup-github.sh             # one-time publish helper
├── .github/workflows/publish.yml
├── styles.scss                 # callout styling
└── data/                       # raw/ and processed/ (gitignored)
```

## License

Course text and figures: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Code snippets: MIT. Please attribute and link back if you reuse material.
