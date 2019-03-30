function X_LHS=SampleParameterSpace(ParMatrix, ParNames, number_of_iterations, number_of_samplepts, CosmoSampleFile)
% SAMPLEPARAMETERSPACE takes five arguments (tha parameter matrix, a vector
% of parameter names, the number of iterations, the number of sampling 
% points and a file name) and writes the optimal sampling to the requested 
% file.
%
% SYNOPSIS: SampleParameterSpace(ParMatrix, ParNames, number_of_iterations, 
%                                number_of_samplepts, CosmoSampleFile)
%
% where 
%
% ParMatrix            .... is a (n x 2) matrix with the lower and upper
%                           parameter limits of n parameters
% ParNames             .... a vector of length n with the names of the n
%                           parameters considered.
% number_of_iterations .... is the number of sample iterations from which 
%                           the best one is finally chosen
% number_of_samplepts  .... the number of sample points in the sample
% CosmoSampleFile      .... file to which the sample is written

%% 1) SET UP UQlab INPUT MODEL
for ii = 1:size(ParMatrix,1)
    inputopts.Marginals(ii).Name = ParNames{ii};
    inputopts.Marginals(ii).Type = 'Uniform';
    inputopts.Marginals(ii).Parameters = ParMatrix(ii,:);
end

% Create input model
CosmicInput = uq_createInput(inputopts);

%% 2) PARAMETER SPACE SAMPLING

%number_of_samples = 100;
Samples = cell(1,number_of_iterations);
MinDists = zeros(1,number_of_iterations);

for jj = 1:number_of_iterations
    if mod(jj,1000)==0
        disp(jj)
    end
    %%%%%%%%%%%%% THIS IS THE CORE OF THIS SCRIPT %%%%%%%%%%%%%
    % Sample input parameter space
   
    X_LHS = uq_getSample(CosmicInput,number_of_samplepts,'LHS');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Samples{jj} = X_LHS;
    
    md = MinDistance(X_LHS);
    MinDists(jj) = md;
end

maxindx = find(MinDists == max(MinDists(:)));

X_LHS = Samples{maxindx};

%% 5) WRITE SAMPLED POINTS TO FILE
dlmwrite(CosmoSampleFile, X_LHS, 'delimiter', ',', 'precision',9)
end

