function plot_errorbars(bars, xlims, ylims)
% Plots a list of error bars with optional x and y limits.
% The list bars is a list of tuples (or any iterable) containing
% (mean value, error plus/minus, label)
%
% For example (160, 3, 'A') draws an error bar from 157 to 163, with the
% legend label 'A`)
%
% Parameters
% ----------
%
% bars : list
% list of tuples in form (mean, error +/-, label)
%
% x-lims : tuple
% tuple containing min and max values for x axis
%
% y-lims : tuple, optional
% tuple containing min and max values for y axis ( the default is (-1, 1))
%
% Example
% -------
% >>> plot_errorbars([(160, 3, 'A'), (170, 9, 'B')], xlims=(150, 180))

figure
i = 0.0;
for j = 1:length(bars)
bar = bars{j};
errorbar(bar{1}, i, bar{2}, 'o', 'label', bar{3}, 'capsize', 10, 'capthickness', 2);
i = i + 0.2;
end

% ylim(ylims)
xlim(xlims)
legend()
set(gca, 'YTick', [])
end