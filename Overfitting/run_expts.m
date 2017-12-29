%Script that runs the set of necessary experiments

Q_f = 5:5:20; % Degree of true function
N = 40:40:120; % Number of training examples
var = 0:0.5:2.0; % Variance of stochastic noise

% expt_data_mat = zeros(length(Q_f), length(N), length(var));

% expt_data_mat_mean = zeros(length(Q_f), length(N), length(var));
% expt_data_mat_median = zeros(length(Q_f), length(N), length(var));

for ii = 1:length(Q_f)
    for jj = 1:length(N)
        for kk = 1:length(var)
            over_fit = computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500);
            expt_data_mat_mean(ii,jj,kk) = mean(over_fit);
            expt_data_mat_median(ii,jj,kk) = median(over_fit);
%             expt_data_mat_median(ii,jj,kk) = median(computeOverfitMeasure(Q_f(ii),N(jj),1000,var(kk),500));            
        end
    end
    fprintf('.');

%             expt_data_mat_mean = mean(computeOverfitMeasure(5, 40, 1000, 0,500))
%             expt_data_mat_median = median(computeOverfitMeasure(5,40,1000,0,500))            
end

subplot(2,3,1);
plot(N, squeeze(expt_data_mat_mean(2,:,1)), N, squeeze(expt_data_mat_mean(2,:,2)), N, squeeze(expt_data_mat_mean(2,:,3)), N, squeeze(expt_data_mat_mean(2,:,4)), N, squeeze(expt_data_mat_mean(2,:,5)));
title('Varying N and fixed Q_f (10)');
xlabel('N');
ylabel('Mean error');
% legend('var = 0.0', 'var = 0.5', 'var = 1.0', 'var = 1.5', 'var = 2.0');

subplot(2,3,2);
plot(var, squeeze(expt_data_mat_mean(1,3,:)), var, squeeze(expt_data_mat_mean(2,3,:)), var, squeeze(expt_data_mat_mean(3,3,:)), var, squeeze(expt_data_mat_mean(4,3,:)));
title('Varying var and fixed N (120)');
xlabel('Variance');
ylabel('Mean error');
% legend('Q_f = 5', 'Q_f = 10','Q_f = 15','Q_f = 20');

subplot(2,3,3);
plot(Q_f, squeeze(expt_data_mat_mean(:,1,5)), Q_f, squeeze(expt_data_mat_mean(:,2,5)), Q_f, squeeze(expt_data_mat_mean(:,3,5)));
title('Varying Q_f and fixed var (2)');
xlabel('Q_f');
ylabel('Mean error');
% legend('N = 40', 'N = 80', 'N = 120');

subplot(2,3,4)
plot(N, squeeze(expt_data_mat_median(2,:,1)), N, squeeze(expt_data_mat_median(2,:,2)), N, squeeze(expt_data_mat_median(2,:,3)), N, squeeze(expt_data_mat_median(2,:,4)), N, squeeze(expt_data_mat_median(2,:,5)));
title('Varying N and fixed Q_f (10)');
xlabel('N');
ylabel('Median error');
% legend('var = 0.0', 'var = 0.5', 'var = 1.0', 'var = 1.5', 'var = 2.0');

subplot(2,3,5);
plot(var, squeeze(expt_data_mat_median(1,3,:)), var, squeeze(expt_data_mat_median(2,3,:)), var, squeeze(expt_data_mat_median(3,3,:)), var, squeeze(expt_data_mat_median(4,3,:)));
title('Varying var and fixed N (120)');
xlabel('Variance');
ylabel('Median error');
% legend('Q_f = 5', 'Q_f = 10','Q_f = 15','Q_f = 20');

subplot(2,3,6);
plot(Q_f, squeeze(expt_data_mat_median(:,1,5)), Q_f, squeeze(expt_data_mat_median(:,2,5)), Q_f, squeeze(expt_data_mat_median(:,3,5)));
title('Varying Q_f and fixed var (2)');
xlabel('Q_f');
ylabel('Median error');
% legend('N = 40', 'N = 80', 'N = 120');
