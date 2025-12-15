%% 1D signal reconstruction

clear all;
close all;
clc;

% params
load('1d_data_sample.mat','x');
N = size(x,1);

seed = 1113;
rng(seed);

cr = 0.5;
M = round(cr * N);
Phi = randn(M,N) * sqrt(1/M);
Phi = orth(Phi')';
Psi = dctmtx(N);
T = 20;
eps = 1e-5;
stop_earlier = 0;
show_detail = 0;

% reconstruction
y = Phi * x;
hat_h = amp_core(y,Phi,Psi,T,eps,stop_earlier,show_detail);
hat_x = Psi' * hat_h;

% plot
fig_width = 400;
fig_height = 300;
font_name = 'Arial';
font_size = 22;
frame_linewidth = 2.25;
curve_linewidth = 3;
x_min = -N/16;
x_max = N + N/16;
original_color = '#959b9c';
reconstructed_color = [0.4660, 0.6740, 0.1880];

x_ticks = 0:N/4:N;
figure(1);
plot(1:N, x, 'LineWidth', curve_linewidth, 'Color', original_color);
hold on;
plot(1:N, hat_x, '-.', 'LineWidth', curve_linewidth, 'Color', reconstructed_color);
hold off;

xlim([x_min, x_max]);
ylim([-1, 5]);
set(gca, 'XTick', x_ticks);
set(gca, 'YTick', -0.5:1:4.5);
set(gca, 'FontName', font_name, 'FontSize', font_size, 'LineWidth', frame_linewidth);
set(gca, 'layer', 'bottom');
set(gcf, 'Position', [100, 100, fig_width, fig_height]);
set(gcf, 'color', 'w');

fprintf('Reconstruction MSE: %.2e\n', mean((x - hat_x).^2) / mean(x.^2));

%% 2D image reconstruction
clear all;
close all;
clc;

% x = im2double(imread("jetplane.tif"));
x = im2double(imread("house.tif"));
x = x(:,:,1);
imshow(x);

N = size(x, 1);
cr = 0.5;
M = round(cr * N);
Phi = randn(M,N) * sqrt(1/M);
Phi = orth(Phi')';
Psi = dctmtx(N);

T = 20;
eps = 1e-5;
stop_earlier = 0;
show_detail = 0;

chs = size(x, 3);
N1 = size(x, 2);

hat_x = zeros(size(x));
for i = 1:1:chs
    for j = 1:1:N1
        xij = x(:, j, i);
        y = Phi * xij;
        hat_h = amp_core(y,Phi,Psi,T,eps,stop_earlier,show_detail);
        hat_xij = Psi' * hat_h;
        hat_x(:, j, i) = hat_xij;
    end
end

imshow(hat_x);
fprintf('Reconstruction PSNR: %.2f\n', psnr(x, hat_x));




