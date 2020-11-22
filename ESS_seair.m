function ESS = ESS_seair(pars)
    data = load('active_data');
    data = data.active;
    global mu,
    global tau,
    global N,
    global gamma_as,
    global gamma_s,
    global alpha,
    global day,
    global gamma_a;
    data = data(1:day);
    beta = pars; %xu_ma
    %mu = 0.1;  %xu_ma
    %tau = 5;
   % alpha = 0.8;
    %gamma_a = pars(2);
   % gamma_as = 0.17;
    %gamma_s = 0.2;
    tspan = [0:day-1];
    % r0 = beta1*exp(-mu*tau)*((alpha*(gamma_s+mu_d+mu)+alphab*(gamma_a+mu)...
    %     +alpha*theta*gamma_a)/((gamma_s+mu_d+mu)*(gamma_a+mu)));
    data_num = dde23('delayRhs',tau,'delayHist',tspan,[],...
        alpha, beta, tau, mu, gamma_a, gamma_as, gamma_s, N);
    sol = deval(data_num, tspan);
    %y = sol.y;
%     tspan = [0:49];
%   [t, y] = ode45(@SEIRD_rhs, tspan, y0, [],  pars);
    numerical = sol(3,:) + sol(4,:);
    diff = data - numerical';
    ESS = sum(diff.^2);