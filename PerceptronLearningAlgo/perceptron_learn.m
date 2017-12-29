function [ w iterations ] = perceptron_learn( data_in )
    %perceptron_learn Run PLA on the input data
    %   Inputs: data_in: Assumed to be a matrix with each row representing an
    %                    (x,y) pair, with the x vector augmented with an
    %                    initial 1, and the label (y) in the last column
    %   Outputs: w: A weight vector (should linearly separate the data if it is
    %               linearly separable)
    %            iterations: The number of iterations the algorithm ran for
    
    %= tmin + rand(100,10)*(tmax-tmin);
    %w_star_transpose = transpose(w_star_init);

    % 
    
    x = data_in;
    x(:,end) = [];
    
    y = data_in(:,end);
    
    w = zeros(11,1);
    
    iterations = 0;
    
    update = true;
    while update == true
        update = false;
        for t = 1:100
           
            h = x(t,:) * w; 
             if sign(h) ~= sign(y(t))
                w = w + (y(t,1) .* transpose(x(t,:)));
                iterations = iterations + 1;
                update = true;
            end
        end
    end    
end



%     % w = 1 x 11 matrix
%     w_star_init = transpose(rand(1,11));
%     w_star_init(1) = 0;
% 
%     tmin = -1;
%     tmax = 1;
% 
%     % 100 by 1 ones for first column
%     x1 = ones(100,1);
%     % x - 1 x 100 matrix
%     x_rest = tmin + rand(100,10) * (tmax - tmin);
%     x = horzcat(x1,x_rest);
% 
%     temp = ones(100,1);
%     % y = 100 x 1 +1/-1 labels
%     for i = 1 : 100
%         y1 = sign(x(i,:) * w_star_init);
%         temp(i,1) = y1;
%     end
%     y = temp;
%     training_set = horzcat(x,y);
% 
%     
%     %= tmin + rand(100,10)*(tmax-tmin);
%     %w_star_transpose = transpose(w_star_init);
% 
%     % 
%     w = zeros(11,1);
%     
%     iterations = 0;
%     
%     update = true;
%     while update == true
%         for n = 1:1000
%             update = false;
%             for t = 1:100
%                 h = x(t,:) * w;    
%                 if sign(h) ~= sign(y(t))
%                     w = transpose(w) + y(t,1)*x(t,:);
%                     iterations = iterations + 1;
%                     update = true;
%                 end
%             end
%         end   
%     end    
% end