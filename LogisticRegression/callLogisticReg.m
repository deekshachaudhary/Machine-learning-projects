clevelandtrain = csvread('clevelandtrain.csv',1,0);
trainXZeroOne = clevelandtrain(:,1:13);
trainYZeroOne = clevelandtrain(:,14);

trainX = clevelandtrain(:,1:13);
trainY = clevelandtrain(:,14);
for i = 1 : length(trainY) 
    if trainY(i,:) == 0
        trainY(i,:) = -1;
    end
end

clevelandtest = csvread('clevelandtest.csv',1,0);
testXZeroOne = clevelandtest(:,1:13);
testYZeroOne = clevelandtest(:,14);

testX = clevelandtest(:,1:13);
testY = clevelandtest(:,14);
for i = 1 : length(testY) 
    if testY(i,:) == 0
        testY(i,:) = -1;
    end
end

eta = 10^-5;

w_init = zeros(length(trainX(1,:))+1,1);
max_its_10k = 10000;
max_its_100k = 100000;
max_its_1m = 1000000;

[ w_10k, e_in_10k_train ] = logistic_reg( trainX, trainY, w_init, max_its_10k, eta );
[ w_10k, e_in_10k_test ] = logistic_reg( testX, testY, w_init, max_its_10k, eta );

test_error_10k_train = find_test_error( w_10k, trainX, trainY);
test_error_10k_test = find_test_error( w_10k, testX, testY);
% disp(['test_error_10k = ', num2str(test_error_10k)]);

e_in_10k_train
e_in_10k_test

test_error_10k_train
test_error_10k_test


[ w_100k, e_in_100k_train ] = logistic_reg( trainX, trainY, w_init, max_its_100k, eta );
[ w_100k, e_in_100k_test ] = logistic_reg( testX, testY, w_init, max_its_100k, eta );

test_error_100k_train = find_test_error( w_100k, trainX, trainY);
test_error_100k_test = find_test_error( w_100k, testX, testY);

e_in_100k_train
e_in_100k_test

test_error_100k_train
test_error_100k_test


[ w_1m, e_in_1m_train ] = logistic_reg( trainX, trainY, w_init, max_its_1m, eta );
[ w_1m, e_in_1m_test ] = logistic_reg( testX, testY, w_init, max_its_1m, eta );

test_error_1m_train = find_test_error( w_1m, trainX, trainY);
test_error_1m_test = find_test_error( w_1m, testX, testY);

e_in_1m_train
e_in_1m_test

test_error_1m_train
test_error_1m_test


glm_val_train = glmfit(testXZeroOne, testYZeroOne, 'binomial')
glm_val_test = glmfit(testXZeroOne, testYZeroOne, 'binomial')






% 10k - 0.3092
% 100k - 0.2069
% 1m - 0.1310