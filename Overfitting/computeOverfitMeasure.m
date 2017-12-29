function [ overfit_m ] = computeOverfitMeasure( true_Q_f, N_train, N_test, var, num_expts )
%COMPUTEOVERFITMEASURE Compute how much worse H_10 is compared with H_2 in
%terms of test error. Negative number means it's better.
%   Inputs
%       true_Q_f: order of the true hypothesis
%       N_train: number of training examples
%       N_test: number of test examples
%       var: variance of the stochastic noise
%       num_expts: number of times to run the experiment
%   Output
%       overfit_m: vector of length num_expts, reporting each of the
%                  differences in error between H_10 and H_2
sigma = sqrt(var);
overfit_m = zeros(1,num_expts);
for t = 1:num_expts
    [train_set, test_set] = generate_dataset(true_Q_f, N_train, N_test, sigma);
    
    train_set_x = train_set(:,1);
%    train_set_x = train_set(:,1);
    test_set_x = test_set(:,1);
%    test_set_x_d10 = test_set(:,1);
    
    train_set_y = train_set(:,2);
    test_set_y = test_set(:,2);
   
    z_train_d2 = computeLegPoly(train_set_x,2);
    z_train_d10 = computeLegPoly(train_set_x,10);
    z_test_d2 = computeLegPoly(test_set_x,2);
    z_test_d10 = computeLegPoly(test_set_x,10);
    
    w_2d = glmfit(z_train_d2, train_set_y, 'normal', 'constant', 'off');
    w_10d = glmfit(z_train_d10, train_set_y, 'normal', 'constant', 'off');
    
    h_d2 = (z_test_d2) * w_2d;
    h_d10 = (z_test_d10) * w_10d;
    
    Eout_d2 = (1 ./ N_test) .* sum((h_d2 - test_set_y) .^ 2);
    Eout_d10 = (1 ./ N_test) .* sum((h_d10 - test_set_y) .^ 2);

    overfit_m(1,t) = Eout_d10 - Eout_d2;
    
end