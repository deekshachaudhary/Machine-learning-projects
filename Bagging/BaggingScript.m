load zip.train

subsample = zip(find(zip(:,1)==1 | zip(:,1) == 3),:);
yTrain1And3 = subsample(:,1) - 2;
xTrain1And3 = subsample(:,2:257);

subsample = zip(find(zip(:,1)==3 | zip(:,1) == 5),:);
yTrain3And5 = subsample(:,1) - 4;
xTrain3And5 = subsample(:,2:257);

err1And3 = zeros(1,50);
err3And5 = zeros(1,50);

for i=1:50
    
   err1And3(i) = BaggedTrees(xTrain1And3,yTrain1And3,i); 
   err3And5(i) =BaggedTrees(xTrain3And5,yTrain3And5,i);
   i
end

figure();
plot(1:50,err1And3);
title("Out of Bag Error of Varying Numbers of Bags for 1 and 3");
xlabel("Number of Bags");
ylabel("Out of Bag Error");
figure();
plot(1:50,err3And5);
title("Out of Bag Error of Varying Numbers of Bags for 3 and 5");
xlabel("Number of Bags");
ylabel("Out of Bag Error");