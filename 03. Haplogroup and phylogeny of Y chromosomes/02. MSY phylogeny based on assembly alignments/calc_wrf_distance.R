#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 3) {
  stop("Usage: Rscript calc_wrf_distance.R <treeA_file> <treeB_file> <output_file>")
}

treeA_file <- args[1]
treeB_file <- args[2]
output_file <- args[3]
library(ape)
library(phangorn)

treeA <- read.tree(treeA_file)
treeB <- read.tree(treeB_file)
wrf_distance <- wRF.dist(treeA, treeB, normalize = FALSE)
cat(wrf_distance, file = output_file)

