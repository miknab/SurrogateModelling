function [ k, procED ] = preprocessEmulatorED( ED, trim )
% PREPROCESSEMULATOR takes in a structure from a .mat file. It is assumed to
% have the structure as used for the construction of EuclidEmulator, i.e. it
% is assumed the ED has the fields k, X and B where k is the vector of k
% values at which the boost factor is sampled, X is the (n_ED x d) matrix of
% n_ED many d-dimensional cosmological parameter vectors and B is a ( n_ED x
% [n_k*n_z])-matrix containing n_ED different boost factors, measured at the
% n_k different k modes for each of the n_z redshifts.

if ~exist('trim', 'var')
    trim = ED.k(end);
end

k = ED.k;
k = k(k <= trim);
procED.X = ED.X;
procED.Y = log(ED.B); % remember that taking the log of the actual data
                     % can lead to much better emulation results

end

