function [myPCE, PCECoeffs, PCEIndices] = ExampleFunction()
%EXAMPLEFUNCTION (by Mischa Knabenhans) showcases how and in which order
%one can work with the functions provided in this directory.

% Get the parameter space of interest
Large6DParSpace

% Compute a UQ input model
cosmicInput = CreateUQInput(ParMatrix, ParNames);

% Load the experimental design data
EDfile = strcat('/Users/mischaknabenhans/Desktop/Research/',...
                'PhD_Projects/Prj1_DMEmulator/EuclidEmulator1/',...
                '09_BIGGERSPACE/MediumParSpace_capOmega/ED_MS6D_N50.mat');
ED = load(EDfile);

% Pre-process the ED (if necessary)
trim = 10;
[k, ppED] = preprocessEmulatorED(ED, trim);

% Define hyperparameters for surrogate model
hyperparameters.MaxPolyDeg = 15;
hyperparameters.pcaVariance = 0.99999;
hyperparameters.qNorm = 0.5;
hyperparameters.MaximalInteraction = 2;

% Compute polynomial chaos expansion of ED
[myPCE, PCECoeffs, PCEIndices] = CreatePCE(ppED, hyperparameters, cosmicInput);


end

