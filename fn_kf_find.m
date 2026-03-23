function akf_result = fn_kf_find(T, P, akf, p)

% akf = load("akf_d2.dat"); 
% p = load("pressure_kPa.dat"); % pressure, kPa

x_akf_T = (akf(:,1)); % temperature
y_akf_1 = (akf(:,2)); % 1bar
y_akf_10 = (akf(:,3)); % 10bar
y_akf_20 = (akf(:,4)); % 20bar
y_akf_23 = (akf(:,5)); % 23.4bar
y_akf_30 = (akf(:,6)); % 30bar
y_akf_40 = (akf(:,7)); % 40bar
y_akf_50 = (akf(:,8)); % 50bar

akf_data = [y_akf_1, y_akf_10, y_akf_20, y_akf_23, y_akf_30, y_akf_40, y_akf_50]; 

akf_T = interp1(x_akf_T, akf_data, T, 'linear','extrap');
akf_result = interp1(p, akf_T, P, 'linear','extrap');