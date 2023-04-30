%% Exercise: Bad Initial Conditions
% 2023/4/30 by Jack
clear; close all;
% zs = gen_data(x0=5., dx=2., count=100, noise_factor=10)
% data = g_h_filter(data=zs, x0=100., dx=2., dt=1., g=0.2, h=0.02)
% plot_g_h_results(measurements=zs, filtered_data=data)

measurements = gen_data(5, 2, 100, 10);
data = g_h_filter(measurements, 100, 2, 1, .2, 0.02);


day = 0:length(measurements)-1;
figure;plot(day,measurements,'ko',day ,data,"b-.");grid;


function measurements = gen_data(x0, dx, count, noise_factor)
    measurements = zeros(1,count);
    for i = 1:count
        measurements(i) = x0 + dx*i + randn()*noise_factor;
    end
end

function results = g_h_filter(data, x0, dx, dt, g, h)
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