function [ z ] = computeLegPoly( x, Q )
%COMPUTELEGPOLY Return the Qth order Legendre polynomial of x
%   Inputs:
%       x: vector (or scalar) of reals in [-1, 1]
%       Q: order of the Legendre polynomial to compute
%   Output:
%       z: matrix where each column is the Legendre polynomials of order 0 
%          to Q, evaluated atthe corresponding x value in the input

x_cols = length(x);
z = ones(x_cols, Q+1);

z(:,1) = ones(x_cols,1);
z(:,2) = x;

for i = 3 : (Q + 1)
    k = i - 1;
    z(:,i) = ((2*k-1)/k).* x .* z(:,i-1) - (((k-1)/k)* z(:,i-2));
end

z = z(:, 1:(Q+1));