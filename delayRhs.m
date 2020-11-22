function v = delayRhs(t,y,Z,alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N)
ylag = Z(:,1);
v = zeros(4,1);
v(1) = mu*N -beta*(y(3)+y(4))*y(1)/N - mu*y(1);
v(2) =  beta*(y(3)+y(4))*y(1)/N - exp(-mu*tau)*beta*(ylag(3)+ylag(4))*...
        ylag(1)/N - mu*y(2);
v(3) = alpha*exp(-mu*tau)*beta*(ylag(3)+ylag(4))*ylag(1)/N -(gamma_a+...
       +gamma_as+mu)*y(3);
v(4) = (1- alpha)*exp(-mu*tau)*beta*(ylag(3)+ylag(4))*ylag(1)/N +...
    gamma_as*y(3)-(gamma_s+mu)*y(4);
end
