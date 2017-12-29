

function [ num_iters bounds] = perceptron_experiment ( N, d, num_samples )
%perceptron_experiment Code for running the perceptron experiment in HW1
%   Inputs: N is the number of training examples
%           d is the dimensionality of each example (before adding the 1)
%           num_samples is the number of times to repeat the experiment
%   Outputs: num_iters is the # of iterations PLA takes for each sample
%            bounds is the theoretical bound on the # of iterations
%              for each sample
%      (both the outputs should be num_samples long)
    
    R_vector = zeros(1,1000);
    rho_vector = zeros(1,1000);
    bounds_vector = zeros(1,1000);
    bounds_iterations_vector = zeros(1,1000);
    
    R_100 = zeros(1,100);
    rho_100 = zeros(1,100);
    
    iterations_vector = zeros(1,1000);
    for i = 1:num_samples
        % w = 1 x 11 matrix
        w_star_init = transpose(rand(1,11));
        w_star_init(1) = 0;

        tmin = -1;
        tmax = 1;

        % 100 by 1 ones for first column
        x1 = ones(N,1);
        % x - 1 x 100 matrix
        x_rest = tmin + rand(N,d) * (tmax - tmin);
        x = horzcat(x1,x_rest);

        temp = ones(N,1);
        % y = 100 x 1 +1/-1 labels
        for j = 1 : N
            y1 = sign(x(j,:) * w_star_init);
            temp(j,1) = y1;
            
            % for bounds
            R_100(1,j) = norm(x);
            rho_100(1,j) = y1*(x(j,:) * w_star_init);
                                    
        end
        R_vector(1,i) = max(R_100);
        rho_vector(1,i) = max(rho_100);

        y = temp;
        training_set = horzcat(x,y);
        
        [w, iterations] = perceptron_learn(training_set);
        iterations_vector(i) = iterations;
        
        bounds_vector(1,i) = (dot((R_vector(1,i)^2) , ((norm(w_star_init))^2)))/rho_vector(1,i)^2;
        
        bounds_iterations_vector(1,i) = log((bounds_vector(1,i) - iterations_vector(1,i)));

    end
    
    
    subplot(2,1,1)
    histogram(iterations_vector);
    title('iterations');

    subplot(2,1,2);
%     histogram(bounds_iterations_vector);
    set(gca,'Xscale','log');
    title('bounds');

end












% function [ num_iters bounds] = perceptron_experiment ( N, d, num_samples )
% %perceptron_experiment Code for running the perceptron experiment in HW1
% %   Inputs: N is the number of training examples
% %           d is the dimensionality of each example (before adding the 1)
% %           num_samples is the number of times to repeat the experiment
% %   Outputs: num_iters is the # of iterations PLA takes for each sample
% %            bounds is the theoretical bound on the # of iterations
% %              for each sample
% %      (both the outputs should be num_samples long)
%     
%     R_vector = zeros(1,100);
%     rho_vector = zeros(1,100);
%     bounds_vector = zeros(1,100);
%     
%     iterations_vector = zeros(1000,1);
%     for i = 1:num_samples
%         % w = 1 x 11 matrix
%         w_star_init = transpose(rand(1,11));
%         w_star_init(1) = 0;
% 
%         tmin = -1;
%         tmax = 1;
% 
%         % 100 by 1 ones for first column
%         x1 = ones(N,1);
%         % x - 1 x 100 matrix
%         x_rest = tmin + rand(N,d) * (tmax - tmin);
%         x = horzcat(x1,x_rest);
% 
%         temp = ones(N,1);
%         % y = 100 x 1 +1/-1 labels
%         for j = 1 : N
%             y1 = sign(x(j,:) * w_star_init);
%             temp(j,1) = y1;
%             
%             % for bounds
%             R = max(norm(x));
%             rho = min(y1*(x(j,:) * w_star_init));
%             bounds_vector(j) = (R^2 * (norm(w_star_init)^2))/rho^2;
%             
%         end
%         y = temp;
%         training_set = horzcat(x,y);
%         
%         [w, iterations] = perceptron_learn(training_set);
%         iterations_vector(i) = iterations;
% %         bounds_iterations_vector(i) = log(bounds_vector - iterations_vector);
% 
%     end
%     
%     
%     subplot(2,1,1)
%     histogram(iterations_vector);
%     title('iterations');
% 
% %     subplot(2,1,2);
% %     histogram(bounds_iterations_vector);
% %     title('bounds');
% 
% end
% 
