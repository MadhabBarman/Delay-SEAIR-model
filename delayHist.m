function y = delayHist(t, alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N)
y = zeros(4,1);
y(2,1) = 0; %E 
y(3,1) = 15; %A
y(4,1) = 20; %I
y(1,1) = N - y(2)- y(3) - y(4); %S