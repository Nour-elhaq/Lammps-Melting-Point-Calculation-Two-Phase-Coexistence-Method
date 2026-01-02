# Interatomic Potential - Lennard-Jones (Argon-like)
# Parameters: epsilon = 1.0, sigma = 1.0, cutoff = 2.5 (in reduced units)

pair_style      lj/cut 2.5
pair_coeff      * * 1.0 1.0 2.5

neighbor        0.3 bin
neigh_modify    delay 5 every 1
