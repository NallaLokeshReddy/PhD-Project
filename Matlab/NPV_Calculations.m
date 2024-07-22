% Calculation of NPV references
clear all
clc

Vdc = 900;
Vl_peak = 325;   % Vl_peak is the desired load voltage peak
Vs_peak = 225;
x = ( Vdc - (2*(Vs_peak + abs(Vl_peak - Vs_peak))) )/1.2
y = 0.2*x
Vnou = Vs_peak + (2*abs(Vl_peak - Vs_peak)) - (Vdc/2) + (x/2) + y
Vnol = Vnou - Vs_peak - abs(Vl_peak - Vs_peak) - y