function [PCMean, PCBasis, weights, explained] = myPCA(Ymat, threshold)
% MYPCA is a simplified version of the function uq_PCA_preproc (to be found
% in my_UQLab_folder/modules/uq_model/builtin/uq_metamodel/ExpDesign/...
% ... Preprocessing/PCA). It takes in a data matrix and a threshold and
% returns the PCA mean, the PC basis, the PC weights and the fraction of
% the total variance retained.

%% Get the PCA and the mean
[PC,lambda,relVar] = pca(Ymat);


%% perform variance-threshold-based selection
maxPC = find(cumsum(relVar/sum(relVar))>threshold,1);

%% Return values
% Preprocessed X (PCA coordinates):
weights = lambda(:,1:maxPC);
% Spectral decay
explained = cumsum(relVar/sum(relVar));
% Mean value
PCMean = mean(Ymat);
% Principal components (eigenvectors)
PCBasis = PC(:,1:maxPC);
end

