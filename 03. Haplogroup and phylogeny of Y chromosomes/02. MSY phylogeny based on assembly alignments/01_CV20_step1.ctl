seed = -1
seqfile = ../../../Gene_tree.CV20.blocks.fasta
treefile = ../../../start.tree.nwk
outfile = 01_CV20_step1.out

ndata = 1
usedata = 3    * 0: no data; 1:seq like; 2:normal approximation
cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?
clock = 2    * 1: global clock; 2: independent rates; 3: correlated rates
model = 7    * 0:JC69, 1:K80, 2:F81, 3:F84, 4:HKY85
ncatG = 5    * No. categories in discrete gamma
BDparas = 1 1 0   * birth, death, sampling
kappa_gamma = 6 2      		* gamma prior for kappa
alpha_gamma = 1 1      * gamma prior for alpha
rgene_gamma = 2 26.3   * gamma prior for rate
sigma2_gamma = 1 10    * gamma prior for sigma^2 (for clock=2 or 3)
burnin = 10000
sampfreq = 10
nsample = 1000
