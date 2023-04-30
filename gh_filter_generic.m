%% generic form of gh filter
% 2023/4/30 by Jack
clear; close all;
weights = [158.0, 164.2, 160.3, 159.9, 162.1, 164.6, 169.6, 167.4, 166.4, 171.0, 171.2, 172.6];

data = g_h_filter(weights, 160, 1, 6/10, 2/3, 1);

day = 0:length(weights)-1;
figure;plot(day,weights,'ko',day,data,"b-.");grid;


function results = g_h_filter(data, x0, dx, g, h, dt)
    x_est = x0;
    len = length(data);
    results = zeros(1,len);
    for i = 1:length(data)
        % prediction step
        x_pred = x_est + (dx*dt);
        %dx = dx;
    
        % update step
        residual = data(i) - x_pred;
        dx = dx + h * residual / dt;
        x_est = x_pred + g * residual;
        results(i) = x_est;
    end
end