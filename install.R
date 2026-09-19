# Course installer for the R track. Run from the repository root:
#   source("install.R")
# Takes 20-60 minutes on a fresh machine.

options(repos = c(CRAN = "https://cloud.r-project.org"))
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
if (!requireNamespace("remotes",     quietly = TRUE)) install.packages("remotes")

cran <- c("Seurat", "dplyr", "ggplot2", "patchwork", "harmony", "clustree",
          "cluster", "Matrix", "hdf5r", "igraph", "reticulate")
install.packages(setdiff(cran, rownames(installed.packages())))

bioc <- c("scDblFinder", "SingleCellExperiment", "scRepertoire", "edgeR",
          "speckle", "glmGamPoi")
BiocManager::install(setdiff(bioc, rownames(installed.packages())), update = FALSE, ask = FALSE)

# Fast Wilcoxon for FindAllMarkers
if (!requireNamespace("presto", quietly = TRUE)) remotes::install_github("immunogenomics/presto")

# Reference mapping (large; downloads a ~1 GB reference on first use)
if (!requireNamespace("Azimuth", quietly = TRUE)) remotes::install_github("satijalab/azimuth", quiet = TRUE)
if (!requireNamespace("SeuratData", quietly = TRUE)) remotes::install_github("satijalab/seurat-data", quiet = TRUE)

# Leiden clustering via reticulate (optional; falls back to Louvain if this fails)
tryCatch({
  reticulate::py_install(c("leidenalg", "igraph"), pip = TRUE)
}, error = function(e) message("leidenalg install skipped; use algorithm = 1 (Louvain)."))

message("\nInstalled. Verify with: library(Seurat); library(scRepertoire)")
