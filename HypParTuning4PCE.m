function [ hyperpars ] = HypParTuning4PCE( ED, inputModel )
%HYPPARTUNING4PCE performs the optimization of hyperparameters for a
% specific surrogate model sampled in a d-dimensional parameter space. 
% Given an experimental design it tries to minimize the total LOO error.

% Check input
if ~exist('inputModel', 'var')
    % Don't do anything. This parameter is optional.
end

% Set up grid in hyperparameter space
MaxPolyDeg = 20;
pcaVariance = 1-10.^(-10:1);            % 1-10^(-10), 1-10^(-9),..., 0.999, 0.99, 0.9
qNorm = 0:0.1:1;                        % 0.0, 0.1, 0.2, 0.3, ... , 0.9, 1.0
MaximalInteraction = 1:size(ED.X,2);    % 1, 2, 3, ..., d

errvec = [];
for p=MaxPolyDeg
    for prec=pcaVariance
        for q=qNorm
            for mi=MaximalInteraction
                hyperparameters.MaxPolyDeg = p;
                hyperparameters.pcaVariance = prec;
                hyperparameters.qNorm = q;
                hyperparameters.MaximalInteraction = mi;
                
                myPCE_LARS = CreatePCE(ED, hyperparameters);
                
                sumerr = 0;
                for cntr = size(myPCE_LARS.Error,2);
                    sumerr = sumerr + myPCE_LARS.Error(cntr).LOO;
                end
                
                errvec = [errvec, sumerr];
            end
        end
    end
end

disp(errvec);


end