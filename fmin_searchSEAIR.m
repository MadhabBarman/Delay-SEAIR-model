close all;
clear all; clc;
global mu,
global tau,
global N,
global gamma_as,
global gamma_s,
global alpha,
global day,
global gamma_a;
day = 100;
data = load('active_data');
data = data.active;
data = data(1:day);
N = 135e4;  %saha
%N = 500000;
tspan = [0:day-1];
mu = 0.0723;  %xu_ma
tau = 4.0;
alpha = 0.8;
gamma_as = 1/14;
gamma_s =   1/7;
gamma_a = 2/7;
theta = fminsearch(@ESS_seair, [0.2]);
%pars = [theta, ess];
beta = theta; %xu_ma
%gamma_a = pars(2);
%N = 500000;

% r0 = beta1*exp(-mu*tau)*((alpha*(gamma_s+mu_d+mu)+alphab*(gamma_a+mu)...
%     +alpha*theta*gamma_a)/((gamma_s+mu_d+mu)*(gamma_a+mu)));
data_num = dde23('delayRhs',tau,'delayHist',tspan,[],...
    alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N);
sol = deval(data_num, tspan);
figure(1);
plot(data,'-o');
hold on
plot(sol(3,:)+sol(4,:))
legend('Real data','Estimated data')
%xc1 = theta(1);xc2 = theta(2);
%text(1,225,['\beta = ',num2str(xc1)])
%text(1,200,['\gamma = ',num2str(xc2)])
%title(['\beta = ',num2str(beta),' and \chi = ',num2str(gamma_a)])
%title(['\beta = ',num2str(beta)])
ax = gca;
ax.XAxis.FontSize = 12;
ax.YAxis.FontSize = 12;

% disp("MAE")
% eme = abs(data'-(sol(3,:)+sol(4,:)));
% EME = sum(eme)/length(eme)
% 
% disp("RMSE")
% RMSE = sqrt(sum(eme.^2)/length(eme))
