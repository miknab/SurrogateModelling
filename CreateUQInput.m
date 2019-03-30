function [ CosmicInput ] = CreateUQInput( ParMatrix, ParNames )
%CREATEUQINPUT (by Mischa Knabenhans) reads a parameter space in form of a
%matrix with lower and upper parameter range limits and a vector with the
%names of the parameters. From this input a UQ input model is created and
%returned.

for ii = 1:size(ParMatrix,1)
    inputopts.Marginals(ii).Name = ParNames{ii};
    inputopts.Marginals(ii).Type = 'Uniform';
    inputopts.Marginals(ii).Parameters = ParMatrix(ii,:);
end

CosmicInput = uq_createInput(inputopts);

end

