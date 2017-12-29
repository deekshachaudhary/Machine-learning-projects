function [ test_error ] = find_test_error( w, X, y )
%FIND_TEST_ERROR Find the test error of a linear separator
%   This function takes as inputs the weight vector representing a linear
%   separator (w), the test examples in matrix form with each row
%   representing an example (X), and the labels for the test data as a
%   column vector (y). X does not have a column of 1s as input, so that 
%   should be added. The labels are assumed to be plus or minus one. 
%   The function returns the error on the test examples as a fraction. The
%   hypothesis is assumed to be of the form (sign ( [1 x(n,:)] * w )

N = length(X(:,1)); % number of rows in X
x_ones = ones(N,1);
X = [x_ones,X]; % feature vector 145x14 augmented with a 1
% X = zscore(X);
theta = zeros(1,N); % logistic function
% w = [0; w] % 14 x 1

s = X * w;
threshold = 0.5;

for i = 1:N
    theta1 = exp(s(i)) / (1 + exp(s(i)));
    theta(1,i) = sign(theta1-threshold);
end

theta_transpose = transpose(theta);
hysum = sum(theta_transpose ~= y);

test_error = 1/N * sum(hysum);

end