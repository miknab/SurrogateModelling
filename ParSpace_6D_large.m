%% Large 6D cosmological parameter space

ParMatrix = [0.03   0.06;   % (capital) Omega_b [1]
             0.1    0.9;    % (capital) Omega_m [2]
             0.7    1.3;    % n_s               [3]
             0.55   0.8;    % h                 [4]
            -2.0    0.0;    % w_0               [5]
             0.5    1.0];   % sigma_8           [6]

ParNames = {'Omega_b' 'Omega_m' 'n_s' 'h' 'w_0' 'sigma_8'};

% LEGEND
% ============
% [1]   lower bound from DES [arXiv:1708.01530v3], page 6, Table 1, 
%       upper bound from CLASS (higher values lead to invalid YHe values
%       for BBN)
% [2]   lower and upper bound from DES [arXiv:1708.01530v3], page 6, Table 1
% [3]   lower and upper bound from KiDS + GAMA [arXiv:1706.05044v2], page 12, Table 1
% [4]   lower bound from DES [arXiv:1708.01530v3], page 6, Table 1,
%       upper bound from CLASS (higher values lead to invalid \omega_b)
% [5]   lower and upper bound from DES [arXiv:1708.01530v3], page 6, Table 1
% [6]   personal choice, no reference (all papers have only prior on A_s)
%
