function rho_result = fn_rho_find(T,P, rho, p)

% rho = load("rhof_d2.dat"); 
% p = load("pressure_kPa.dat"); % pressure, kPa

x_rho_T = (rho(:,1)); % temperature
y_rho_1 = (rho(:,2)); % 1bar
y_rho_10 = (rho(:,3)); % 10bar
y_rho_20 = (rho(:,4)); % 20bar
y_rho_23 = (rho(:,5)); % 23.4bar
y_rho_30 = (rho(:,6)); % 30bar
y_rho_40 = (rho(:,7)); % 40bar
y_rho_50 = (rho(:,8)); % 50bar

rho_data = [y_rho_1, y_rho_10, y_rho_20, y_rho_23, y_rho_30, y_rho_40, y_rho_50]; 

rho_T = interp1(x_rho_T, rho_data, T, 'linear','extrap'); % T에 따라서 rho 추출
rho_result = interp1(p, rho_T, P, 'linear','extrap'); % p일 때 결과





