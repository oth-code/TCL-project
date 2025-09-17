# Tcl-SCPI Lab – Automatisation de mesures d'un filtre RC passe-bas

## 🎯 Objectif
Ce projet montre comment piloter un oscilloscope en **Tcl/SCPI** via **VISA**
pour mesurer la réponse fréquentielle d’un **filtre RC passe-bas**.

- Générateur de signaux → entrée du filtre
- Filtre RC (R=10 kΩ, C=10 nF, Fc ≈ 1,6 kHz)
- Oscilloscope CH1 = entrée (Vin)
- Oscilloscope CH2 = sortie (Vout)
- Script Tcl → configure instruments, mesure Vpp, enregistre CSV

## 📂 Structure