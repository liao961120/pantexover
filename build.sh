#~~~~~~~~~~~~~ Script for Compiling Markdown Files to LaTeX Book ~~~~~~~~~~~~~#
#' Source of Markdown content and other dependencies needed for compilation
#'   are located in `src/`. Run `bash build.sh` generates `content.tex`,
#'   which is referenced in `main.tex`.
#' [Software Dependencies]
#'   pandoc: https://github.com/jgm/pandoc/releases
#'   pandoc-crossref: https://github.com/lierdakil/pandoc-crossref/releases
#' [Source Code]
#'   The most recent version of this template can be found on GitHub
#'   <https://github.com/liao961120/pantexover/book-zh-tw>.
#' [Author]
#'   Yongfu Liao (https://yongfu.name)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
pandoc src/0*.md src/deps/app.md src/appendix*.md src/deps/references.md src/variables.md \
    -o "content.tex" --from markdown+smart+superscript+subscript \
    --top-level-division="chapter" \
    --filter="pandoc-crossref" --citeproc \
    --csl="src/deps/apa.csl" \
    --bibliography="src/references.bib" \
    --lua-filter="src/deps/custom-box.lua" \
    --toc --toc-depth=2 --number-sections --file-scope \
    -V indent
