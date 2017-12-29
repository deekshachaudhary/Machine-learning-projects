function [ w, e_in ] = logistic_reg( X, y, w_init, max_its, eta )
%LOGISTIC_REG Learn logistic regression model using gradient descent
%   Inputs:
%       X : data matrix (without an initial column of 1s)
%       y : data labels (plus or minus 1)
%       w_init: initial value of the w vector (d+1 dimensional)
%       max_its: maximum number of iterations to run for
%       eta: learning rate
    
%   Outputs:
%       w : weight vector
%       e_in : in-sample error (as defined in LFD)

    N = length(X(:,1)); % number of rows in X
    d = length(X(1,:)); % number of columns in X
    x1 = ones(N,1);
    X = [x1, X];
%     X = zscore(X);
    w = w_init;
    num_iter = 1;
    
    for i = 1 : max_its
        yxw_product = y .* (X * w);
        one_plus_exp_yxw = 1 + exp(yxw_product);
        y_By_OnePlusExp = y ./ one_plus_exp_yxw;
                
        gt = (-1 / N) * (transpose(y_By_OnePlusExp) * X);
        vt = -gt;

        w_transpose = transpose(w);
        w_transpose(1,:) = w_transpose(1,:) + (eta * vt);
        w = transpose(w_transpose);

        gt_if_less_than = all(gt(:) < 0.001);
        if gt_if_less_than == 1
            break;
        end
    end
    i
    xy_By_OnePlusExp = log(1 + exp(-1 * yxw_product));

    e_in = (1/N) * sum(xy_By_OnePlusExp);
end

% glmfit = .4074
% 10k = .5847
% 100k - .4937
% 1m - .4354
% w'x < 0 = 1; w'x > 0 = -1