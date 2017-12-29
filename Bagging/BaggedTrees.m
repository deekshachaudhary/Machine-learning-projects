function [ oobErr ] = BaggedTrees( X, Y, numBags )
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
    if ismember(1,Y)
        subValue = 2;
    else
        subValue = 4;
    end
    numPoints = size(X,1);
    numFeatures = size(X,2);
    bags = randi([1,numPoints],numBags,numPoints);  
    trees = cell(1,numBags);
    errBags = zeros(1, numBags);
    for i=1:numBags
        bagX = zeros(numPoints, numFeatures);
        bagY = zeros(numPoints,1);
        for j=1:numPoints
            bagX(j,:) = X(bags(i,j),:); 
            bagY(j,1) = Y(bags(i,j),1);
        end
        trees{i} = fitctree(bagX,bagY, 'PredictorSelection','allsplits');
        %trees{i} = fitctree(bagX,bagY, 'SplitCriterion','deviance');
    end
    oobErr = 0;
    for i=1:numBags
        
    end
    for i=1:numPoints
        count = 0;
        prediction = 0;
        for j=1:numBags
            if ~ismember(i,bags(j,:))
                count = count+1;
                prediction = prediction + predict(trees{j},X(i,:));
            end
        end
        prediction = sign((prediction/count)-subValue) + subValue;
        if prediction ~= Y(i)
            oobErr = oobErr + 1;
        end
    end
    oobErr = oobErr/numPoints;

%     oobErr = 0;
%     count = 0;
%     for i=1:numBags
%         oob = zeros(0,numFeatures+1);
%         for j=1:numPoints
%             if ~ismember(j, bags(i,:))
%                 oob = [oob; [X(j,:),j]];
%                 count = count + 1;
%             end
%         end
%         p = predict(trees{i}, oob(:,1:numFeatures));
%         for k=1:size(oob,1)
%             if p(k) ~= Y(oob(k,numFeatures+1))
%                 oobErr = oobErr+1;
%             end
%         end
%         errBags(i) = oobErr/count;
%     end
%     figure()
%     plot(1:numBags, errBags);
%     title("Out of Bag Error for Varying Numbers of Bags");
%     xlabel("Number of Bags");
%     ylabel("Out of Bag Error");
%     oobErr = oobErr/count;
end
