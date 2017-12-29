load zip.train

subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
yTrain1And3 = subsample(:,1) - 2;
xTrain1And3 = subsample(:,2:257);

subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
yTrain3And5 = subsample(:,1) - 4;
xTrain3And5 = subsample(:,2:257);

load zip.test

subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
yTest1And3 = subsample(:,1) - 2;
xTest1And3 = subsample(:,2:257);

subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
yTest3And5 = subsample(:,1) - 4;
xTest3And5 = subsample(:,2:257);

err1And3Train = zeros(1,100);
err3And5Train = zeros(1,100);
err1And3Test = zeros(1,100);
err3And5Test = zeros(1,100);

for n=1:100
    [a, b] = AdaBoost(xTrain1And3,yTrain1And3,xTest1And3,yTest1And3,n);
    [c, d] = AdaBoost(xTrain3And5,yTrain3And5,xTest3And5,yTest3And5,n);
    err1And3Train(n) = a;
    err3And5Train(n) = c; 
    err1And3Test(n) = b;
    err3And5Test(n) = d; 
end
err1And3Train
err1And3Test
err3And5Train
err3And5Test

figure()
plot(1:100, err1And3Train, 'r')
hold on
plot(1:100, err1And3Test, 'b')
title("Test and Train Error of Varying Decision Tree Stumps for 1 and 3")
xlabel("Number of Decision Tree Stumps")
ylabel("Error")
legend("Train Error", "Test Error")

figure()
plot(1:100, err3And5Train, 'r')
hold on
plot(1:100, err3And5Test, 'b')
title("Test and Train Error of Varying Decision Tree Stumps for 3 and 5")
xlabel("Number of Decision Tree Stumps")
ylabel("Error")
legend("Train Error", "Test Error")
