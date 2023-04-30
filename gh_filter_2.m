%% g-h filter by Jack
%2023/4/30
clear; close all;
weights = [158.0, 164.2, 160.3, 159.9, 162.1, 164.6, 169.6, 167.4, 166.4, 171.0, 171.2, 172.6];
time_step = 1.0; % day
scale_factor = 4.0/10;
initial_estimate = 160.;
initial_gain = -1;

[estimates, predictions] = predict_using_gain_guess(initial_estimate, -1, true);

%% plot
len = length(weights);
day=0:1:len;
figure;plot(day,estimates,"b--.", day(2:end),predictions,"r--v");grid;hold on;
plot( day(2:end),weights,"ko",day,160:172);ylim(gca,[156 173]);
xlim(gca,[-0.5 12.5]);
legend('estimate','prediction','measurement','actual','Location','southeast');

function [estimates, predictions] = predict_using_gain_guess(estimated_weight,init_gain_rate, do_print)
% storage for the filtered results
time_step = 1.0; % day
scale_factor = 4.0/10;
gain_factor  = 1/3;
weights = [158.0, 164.2, 160.3, 159.9, 162.1, 164.6, 169.6, 167.4, 166.4, 171.0, 171.2, 172.6];

len = length(weights);

estimates   = zeros(1, len + 1);
predictions = zeros(1, len);

estimates(1) = estimated_weight;
gain_rate    = init_gain_rate;

% most filter literature uses 'z' for measurements
for i = 1:length(weights)
    z = weights(i);
    % predict new position
    predicted_weight = estimated_weight + gain_rate * time_step;

    residual = z - predicted_weight;
    % update filter 
    estimated_weight = predicted_weight + scale_factor * residual;
    gain_rate = gain_rate + gain_factor*residual;

    % save and log
    estimates(i+1) = estimated_weight;
    predictions(i) = predicted_weight;
%     estimates = [estimates, estimated_weight];
%     predictions = [predictions, predicted_weight];
    if do_print
        disp(['estimate: ', num2str(estimated_weight),...
              ', predicted: ', num2str(predicted_weight),...
              ', gain rate: ', num2str(gain_rate)]);
    end
end
end