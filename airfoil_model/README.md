# Airfoil Section Lift / Downforce Model

This folder contains a MATLAB implementation of a basic 2D airfoil aerodynamic model.  
The model uses thin-airfoil theory with a camber-based zero-lift angle correction and a simple stall limiter to estimate lift and downforce.

## Files

airfoil_sim.m  
Core function that computes:
- Lift coefficient (CL)
- Lift force (L)
- Downforce
- Zero-lift angle
- Dynamic pressure

main.m  
Example script showing how to define airfoil parameters and run the model.

## Model Summary

Lift coefficient is computed using thin airfoil theory:

CL = 2π (α − α₀L)

Zero-lift angle α₀L is estimated from mean camber.  
A simple stall model limits CL beyond a specified stall angle.

Lift force is computed from:

L = 0.5 ρ V² S CL

where S = chord × span (unit span by default).

## Inputs

- Angle of attack (degrees)
- Upper and lower camber (fraction of chord)
- Air density
- Freestream velocity
- Chord length
- Span (optional, default = 1 m)

## Running the Example

Open MATLAB in this folder and run:

main.m

The script prints CL, lift force, and downforce for the chosen parameters.

## Future Extensions

- Drag polar modeling
- Reynolds number effects
- Finite-wing corrections
- Integration with lap-time simulation
