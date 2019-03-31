function [ myPCE_LARS, PCECoeffArray, PCEIndexArray ] = CreatePCE(ED, hyperpars, inputModel)
%CREATEPCE (by Mischa Knabenhans) reads in an experimental design stored
%in a matlab structure with only the generic fields X (input) and Y
%(output). Further one has to pass a set of PCE hyperparameters.

if exist('inputModel', 'var')
    % If an input model is passed, choose this one for
    % the evaluation of this function:
    PCEOpts.Input = inputModel;
end

XED = ED.X;
YED = ED.Y;

p = hyperpars.MaxPolyDeg;
prec = hyperpars.pcaVariance;
q = hyperpars.qNorm;
mi = hyperpars.MaximalInteraction;

%  Select the PCE metamodelling toolbox
PCEOpts.Type = 'Metamodel';
PCEOpts.MetaType = 'PCE';

PCEOpts.ExpDesign.Preproc.PreY = 'uq_PCA_preproc';
PCEOpts.ExpDesign.Preproc.PreYPar.VarThreshold = prec;
PCEOpts.ExpDesign.Preproc.PostY = 'uq_PCA_postproc';

%  Select the LARS sparse regression approach
PCEOpts.Method = 'LARS';
%  Select the degree range for the PCE
PCEOpts.Degree = p;
%  Specify truncation options
%  Hyperbolic truncation q (0 < qNorm <= 1)
PCEOpts.TruncOptions.qNorm = q; 
%  Maximum rank of the multi-index alpha
PCEOpts.TruncOptions.MaxInteraction = mi; 
                                                    
%  Specify the experimental design
PCEOpts.ExpDesign.X = XED; %XED_mat;
PCEOpts.ExpDesign.Y = YED; %YED_mat;
%  Create the PCE metamodel (calculate the coefficients) and store it in
%  UQLab
myPCE_LARS = uq_createModel(PCEOpts);

PCECoeffArray = [];
PCEIndexArray = [];
for pce=myPCE_LARS.PCE
    % we can only concatenate several 2D matrices into a ranke 3 tensor
    % using "cat" if the 2D matrices are not stored as sparse matrices
    PCECoeffArray = cat(3, PCECoeffArray, full(pce.Coefficients));
    PCEIndexArray = cat(3, PCEIndexArray, full(pce.Basis.Indices));
end

