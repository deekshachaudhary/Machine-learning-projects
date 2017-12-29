function [ Err ] = OneTree(xTrain, yTrain, xTest, yTest)

    oneTree = fitctree(xTrain,yTrain, 'PredictorSelection','allsplits');
    Err = nnz(predict(oneTree, xTest)-yTest)/size(yTest,1);

end