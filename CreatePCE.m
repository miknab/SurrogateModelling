function [ myPCE_LARS, PCECoeffArray, PCEIndexArray ] = CreatePCE(ED, retainfraction, prec, p, q, mi)
%CREATEPCE (by Mischa Knabenhans) reads in an experimental design stored
%into a .mat file with the three fields named k, X, and B.

%% 1) GET SIMULATION DATA
load(ED)
start = 1;

% We want to consider only values up to a certain upper k limit:
upperkLim = retainfraction*k(end);     
condition = k<upperkLim;
kout= k(condition);
XED = X;
YED = log(B(:,condition));  % Emulating the log of the boost reduces the 
                            % final emulation error

%% 2) SPARSE PCE (LEAST ANGLE REGRESSION)
%  A degree-adaptive, sparse PCE is built from the experimental design
% Specify PCE degree range
% --> sourced out to UQ_SPCE_ConfigPar.m

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
    PCECoeffArray = [PCECoeffArray; pce.Coefficients];
    PCEIndexArray = [PCEIndexArray; pce.Basis.Indices];
end

