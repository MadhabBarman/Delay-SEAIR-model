clear all;
clc;
close all;
beta = 0.7662;
N = 135e4;  %saha
day = 300;
tspan = [0:day-1];
mu = 0.0723;  %xu_ma
%tau = 4.0;
alpha = 0.8;
gamma_as = 1/14;
gamma_s = 1/7;
gamma_a = 2/7;
%param = [alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N];
alphab = 1-alpha;
% r0 = beta*exp(-mu*tau)*((alpha*(gamma_s+mu)+alphab*(gamma_a+gamma_as+mu)...
%     +alpha*gamma_as)/((gamma_a+gamma_as+mu)*(gamma_s+mu)))
%%%%%%%%%%%%%%%%% tau=1 %%%%%%%%%%%%%%%%%%%%%%%%
tau = 1.0;
data_num = dde23('delayRhs',tau,'delayHist',tspan,[],...
    alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N);
sol1 = deval(data_num, tspan);
active1 = sol1(3,:) + sol1(4,:);
%%%%%%%%%%%%%%%%% tau=2 %%%%%%%%%%%%%%%%%%%%%%%%
tau = 2.0;
data_num = dde23('delayRhs',tau,'delayHist',tspan,[],...
    alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N);
sol2 = deval(data_num, tspan);
active2 = sol2(3,:) + sol2(4,:);
%%%%%%%%%%%%%%%%% tau=1 %%%%%%%%%%%%%%%%%%%%%%%%
tau = 3.0;
data_num = dde23('delayRhs',tau,'delayHist',tspan,[],...
    alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N);
sol3 = deval(data_num, tspan);
active3 = sol3(3,:) + sol3(4,:);
%%%%%%%%%%%%%%%%% tau=1 %%%%%%%%%%%%%%%%%%%%%%%%
tau = 4.0;
data_num = dde23('delayRhs',tau,'delayHist',tspan,[],...
    alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N);
sol4 = deval(data_num, tspan);
active4 = sol4(3,:) + sol4(4,:);



 figure(1); hold on
 plot(tspan, active1/N,tspan, active2/N,tspan, active3/N,tspan,...
     active4/N,'linewidth',2)
 legend({'\tau=1.0','\tau=2.0', '\tau=3.0', '\tau=4.0'},'fontsize',12)
 xlabel('Days')
 ylabel('Active Cases(Normalized)')
 %set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
grid()
% figure(2)
% plot(A,I,E,I)
hold off
%display 'Reproduction Number'
 %r0