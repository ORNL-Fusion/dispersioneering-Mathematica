% Calculate number of cells to simulate MPEX device length
% =========================================================================

clear all
close all

saveFig  = 1;
saveData = 1;

% Physical constants:
% =========================================================================
c   = 2.99792458E8;            % Speed of light (m/s)
e_c  = 1.60217662E-19;         % Electron charge (C)
m_e  = 9.10938356E-31;         % Electron mass (kg)
m_p  = 1.6726219E-27;          % Proton mass (kg)
kB  = 1.3807E-23;              % Boltzmann constant (J/K)
mu0 = (4E-7)*pi;               % Magnetic permeability [C/(m^2*s)]
ep0 = 8.854E-12;               % Electric permitivity [C^2/(N*m^2)]

% Derived simulation parameters
% =========================================================================
n0 = 3.0E19;                   % Target density
wpe = sqrt(n0*e_c^2/(ep0*m_e)) % Electron plasma freq.
wpi = sqrt(n0*e_c^2/(ep0*m_p)) % Ion plasma freq.

w = 2*pi*30*1E6;
x = linspace(0, 1.0, 100);
B =1./(0.1+x);
wci = e_c*B./m_p;

R = 0.5; %(wpe/wce)^2
n = R*ep0.*B.^2/m_e; %density profile



