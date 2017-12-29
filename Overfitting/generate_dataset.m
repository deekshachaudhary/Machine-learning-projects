function [ train_set, test_set ] = generate_dataset( Q_f, N_train, N_test, sigma )
%GENERATE_DATASET Generate training and test sets for the Legendre
%polynomials example
%   Inputs:
%       Q_f: order of the hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       sigma: standard deviation of the stochastic noise
%   Outputs:
%       train_set and test_set are both 2-column matrices in which each row
%       represents an (x,y) pair

train_set_x =  2*rand(N_train, 1) - 1;
test_set_x =  2*rand(N_test, 1) - 1;

term_to_normalize = [];

randVar = randn(Q_f + 1,1);

% normalize
for q = 1 : (Q_f + 1)
    term_to_normalize(q) = 1/(2*(q-1) + 1);
end

term_to_normalize = sqrt(sum(term_to_normalize));

z_train =  computeLegPoly(train_set_x, Q_f) * (randVar / term_to_normalize);
z_test =   computeLegPoly(test_set_x, Q_f) * (randVar / term_to_normalize);

epsilon_train = sigma * randn(N_train, 1);
epsilon_test = sigma * randn(N_test, 1);

train_set_y = z_train + epsilon_train;
test_set_y = z_test + epsilon_test;
 
train_set = [train_set_x, train_set_y];
test_set = [test_set_x, test_set_y];



