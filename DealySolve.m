clear all;
clc;
close all;
tic 
beta = 0.7662; %Estimated
N = 135e4;  %Total number of population
day = 300; %total number of days
tspan = [0:day-1];
mu = 0.0723;  %natural death rate
tau = 4.0;  %delay parameter
alpha = 0.8; %fractional constant
gamma_as = 1/14;  %A->I, recovery rate
gamma_s = 1/7;  %removal rate of I
gamma_a = 1/7;  %removal rate of A
param = [alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N];
alphab = 1-alpha; %fractional constant
%%%%%%%%%%%%%% basic reproduction number %%%%%%%%%%%%%%%%%
r0 = beta*exp(-mu*tau)*((alpha*(gamma_s+mu)+alphab*(gamma_a+gamma_as+mu)...
    +alpha*gamma_as)/((gamma_a+gamma_as+mu)*(gamma_s+mu)))
%%%%%%%%%%%%%%%% delay model solver %%%%%%%%%%%%%%%%%%%%%%
data_num = dde23('delayRhs',tau,'delayHist',tspan,[],...
    alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N);
sol = deval(data_num, tspan);
S = sol(1,:);
E = sol(2,:);
A = sol(3,:);
I = sol(4,:);
dfe = [E,A,I];
toc
 figure(1); hold on
 plot(tspan, sol/N,'linewidth',2)
 legend('S','E','A','I')
 xlabel('Days')
 ylabel('Individuals(Normalized)')
 %set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
grid()
% figure(2)
% plot(A,I,E,I)
hold off
%display 'Reproduction Number'
 %r0
 
 %%%%%%%%%%%%%%local stability%%%%%%%%
 if beta*exp(-mu*tau) < min(gamma_a, gamma_s)
     disp('DFE global condition satisfied')
 elseif gamma_a==gamma_s
     disp('EE global condition satisfied')
 end