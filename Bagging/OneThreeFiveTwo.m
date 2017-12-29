load zip.train

subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
yTrain1And3 = subsample(:,1);
xTrain1And3 = subsample(:,2:257);

subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
yTrain3And5 = subsample(:,1);
xTrain3And5 = subsample(:,2:257);

load zip.test

subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
yTest1And3 = subsample(:,1);
xTest1And3 = subsample(:,2:257);

subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
yTest3And5 = subsample(:,1);
xTest3And5 = subsample(:,2:257);

err1And3Ensemble = BaggedTrees2(xTrain1And3,yTrain1And3,xTest1And3,yTest1And3,200);
fprintf('The Ensemble error of 1 and 3 is %.4f\n', err1And3Ensemble);
err1And3OneTree = OneTree(xTrain1And3,yTrain1And3,xTest1And3,yTest1And3);
fprintf('The OneTree error of 1 and 3 is %.4f\n', err1And3OneTree);
err3And5Ensemble = BaggedTrees2(xTrain3And5,yTrain3And5,xTest3And5,yTest3And5,200);
fprintf('The Ensemble error of 3 and 5 is %.4f\n', err3And5Ensemble);
err3And5OneTree = OneTree(xTrain3And5,yTrain3And5,xTest3And5,yTest3And5);
fprintf('The OneTree error of 3 and 5 is %.4f\n', err3And5OneTree);
