function [ train_err, test_err ] = AdaBoost( X_tr, y_tr, X_te, y_te, n_trees )
%AdaBoost: Implement AdaBoost using decision stumps learned
%   using information gain as the weak learners.
%   X_tr: Training set
%   y_tr: Training set labels
%   X_te: Testing set
%   y_te: Testing set labels
%   n_trees: The number of trees to use
    train_err = 0;
    test_err = 0;
    numPoints = size(X_tr,1);
    w(1:numPoints,1) = 1/numPoints;
    H_train = zeros(numPoints,1);
    H_test = zeros(size(X_te,1),1);
    for i=1:n_trees
        stump = fitctree(X_tr,y_tr,'minparent',numPoints,'Weights', w, 'SplitCriterion','deviance');
        prediction_train = predict(stump, X_tr);
        prediction_test = predict(stump,X_te);
        err_b = (w'*bsxfun(@ne, prediction_train, y_tr));
        a_b = .5*log((1-err_b)/err_b);
        w = w.*exp(a_b*(bsxfun(@ne, prediction_train, y_tr)*2-1));
        w = w/sum(w);
        H_train = H_train + a_b*prediction_train;
        H_test = H_test + a_b*prediction_test;
    end
%     train_err = sum(abs(H_train-y_tr))/size(X_tr,1);
%     test_err = sum(abs(H_test-y_te))/size(X_te,1);
      train_err = sum(bsxfun(@ne,sign(H_train), y_tr))/numPoints;
      test_err = sum(bsxfun(@ne,sign(H_test), y_te))/numPoints;
end

