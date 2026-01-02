# Automated Melting Point via Two-Phase Coexistence

> **A robust, automated LAMMPS workflow for determining the true melting point of materials using the direct coexistence method.**

[![LAMMPS](https://img.shields.io/badge/LAMMPS-Stable-blue)](https://www.lammps.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📌 Overview

This repository provides a self-contained LAMMPS script to accurately calculate the melting point ($T_m$) of a solid using the **Two-Phase Coexistence Method**.

Unlike standard heating simulations (which suffer from superheating hysteresis) or cooling simulations (which suffer from supercooling), this method simulates a **solid-liquid interface** in direct contact. By running in an iso-enthalpic (NPH) ensemble, the system naturally evolves toward the equilibrium melting temperature.

---

## 🚀 Features

- **Automated Phase Creation**: Automatically initializes a simulation box, creates a solid lattice, and melts half of it to create a perfect interface.
- **Physics-Informed Approach**: Uses the latent heat of fusion to drive the system to $T_m$ without manual trial-and-error.
- **Material Agnostic**: Modular design allows you to easily swap `potential.mod` for any material (metals, alloys, noble gases).
- **Zero-Hysteresis**: Avoids the kinetic barriers of nucleation associated with single-phase melting/freezing.

---

## 🔬 The Physics

In a system where solid and liquid phases coexist at constant pressure and enthalpy ($NPH$ ensemble):
1.  **If $T_{sys} > T_m$**: The solid portion melts, absorbing latent heat. The system cools down.
2.  **If $T_{sys} < T_m$**: The liquid portion freezes, releasing latent heat. The system heats up.

The system acts as a feedback loop, converging naturally to the unique temperature where both phases coexist in equilibrium: **The Melting Point.**

---

## 📂 File Structure

```text
.
├── in.melting       # Main LAMMPS input script
├── potential.mod    # Interatomic potential definition (LJ Argon default)
└── README.md        # This documentation
```

---

## 🛠️ Usage

### Prerequisites
- [LAMMPS](https://www.lammps.org/download.html) installed and accessible via command line (`lmp` or `lmp_mpi`).

### Quality Run (Production)
Run the script directly:
```bash
lmp -in in.melting
```

### Quick Test Run
You can override run times to verify the script works without waiting hours:
```bash
lmp -var RUN_MELT 1000 -var RUN_EQUIL 1000 -var RUN_PROD 5000 -in in.melting
```

---

## 📊 Results

The script outputs a log file (`log.lammps`). You can verify the melting point by plotting the temperature evolution during the coexistence phase.

### Example Experiment: Lennard-Jones Argon
Using the default parameters ($r_{cut} = 2.5\sigma$):
- **Initialization**: FCC Solid at $\rho = 0.8442$.
- **Convergence**: System stabilizes at **$T \approx 0.605$** (reduced units).
- **Literature Value**: $T_m \approx 0.617$ (for infinite system). The slight deviation ($~2\%$) is expected due to finite size effects and cutoff truncation.

**Temperature Evolution:**
> The system starts at an estimated guess ($T=0.61$) and naturally self-adjusts to $T=0.605$ as the solid/liquid interface equilibrates.

---

## ⚙️ Customization

To simulate a different material (e.g., Copper, Aluminum), modify `potential.mod`:

**1. Edit `potential.mod`**:
```lammps
# Example for EAM potential (Al)
pair_style      eam/alloy
pair_coeff      * * Al99.eam.alloy Al
```

**2. Update `in.melting`**:
- Set `TEMP_LOW` and `TEMP_HIGH` to bracket the expected melting point.
- Update `lattice` command to the correct solid density.

---

## 📜 Citation

If you use this method in your research, please consider citing the foundational papers on coexistence methods:
---
[![DOI](https://zenodo.org/badge/1126799476.svg)](https://doi.org/10.5281/zenodo.18133056)


---

*Created for the Computational Materials Science Community.*
