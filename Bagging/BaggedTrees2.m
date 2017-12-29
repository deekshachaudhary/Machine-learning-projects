function [ Err ] = BaggedTrees2( xTrain, yTrain, xTest, yTest, numBags )
%BAGGEDTREES Returns out-of-bag classification error of an ensemble of
%numBags CART decision trees on the input dataset, and also plots the error
%as a function of the number of bags from 1 to numBags
%   Inputs:
%       X : Matrix of training data
%       Y : Vector of classes of the training examples
%       numBags : Number of trees to learn in the ensemble
%
%   You may use "fitctree" but do not use "TreeBagger" or any other inbuilt
%   bagging function

    numPoints = size(xTrain,1);
    numTestPoints = size(xTest,1);
    numFeatures = size(xTrain,2);
    bags = randi([1,numPoints],numBags,numPoints);  
    trees = cell(1,numBags);
    results = zeros(numTestPoints, 0);
    for i=1:numBags
        bagX = zeros(numPoints, numFeatures);
        bagY = zeros(numPoints,1);
        for j=1:numPoints
            bagX(j,:) = xTrain(bags(i,j),:); 
            bagY(j,1) = yTrain(bags(i,j),1);
        end
        trees{i} = fitctree(bagX,bagY, 'PredictorSelection','allsplits');
    end
    for i=1:numBags
        results = [results, predict(trees{i}, xTest)];
    end

    Err = nnz(mode(results, 2) - yTest)/numTestPoints;
end
