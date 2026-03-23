function mu_result = fn_mu_find(T, P, mu, p)

% mu = load("muf_d2.dat"); 
% p = load("pressure_kPa.dat"); % pressure, kPa

x_mu_T = (mu(:,1)); % temperature
y_mu_1 = (mu(:,2)); % 1bar
y_mu_10 = (mu(:,3)); % 10bar
y_mu_20 = (mu(:,4)); % 20bar
y_mu_23 = (mu(:,5)); % 23.4bar
y_mu_30 = (mu(:,6)); % 30bar
y_mu_40 = (mu(:,7)); % 40bar
y_mu_50 = (mu(:,8)); % 50bar

mu_data = [y_mu_1, y_mu_10, y_mu_20, y_mu_23, y_mu_30, y_mu_40, y_mu_50]; 

mu_T = interp1(x_mu_T, mu_data, T, 'linear','extrap'); % T에 따라서
mu_result = interp1(p, mu_T, P, 'linear','extrap'); % p일 때 결과




