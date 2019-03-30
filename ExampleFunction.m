function [] = ExampleFunction()
%EXAMPLEFUNCTION (by Mischa Knabenhans) showcases how and in which order
%one can work with the functions provided in this directory.

ParMatrix = ...
    [0.03   0.06;   % DES + upper bound by CLASS with YHe given by BBN
     0.1    0.9;    % DES
     0.7    1.3;    % KiDS + GAMA
     0.55   0.8;   % DES
     -1.3  -0.7;    % [4] Fig. 8, middle left panel, 99.7% CL (red) 
     0.5    1.0];

ParNames = {'Omega_b' 'Omega_m' 'n_s' 'h' 'w_0' 'sigma_8'};

% X_LHS = SamplePraameterSpace(ParMatrix, ParNames, 100, 50, 'Example_N50.dat');

cosmicInput = CreateUQInput(ParMatrix, ParNames);

ED = 'path/to/ED/mat/file'  % path to the ED .mat file
klim = 0.55                 % upper k limit in percent of maximal k
prec = 1.0 - 10^(-5)        % PCE precision parameter ("a")
p = 15                      % order of PCE polynomials
q = 0.5                     % q-norm for PCE truncation
mi = 2                      % maximum interaction parameter
CreatePCE(ED, klim, prec, p, q, mi)

end

