function cp_result = fn_Cp_find(T, P, cp, p)

% cp = load("cpf_d2.dat"); 
% p = load("pressure_kPa.dat"); % pressure, kPa

x_cp_T = (cp(:,1)); % temperature
y_cp_1 = (cp(:,2)); % 1bar
y_cp_10 = (cp(:,3)); % 10bar
y_cp_20 = (cp(:,4)); % 20bar
y_cp_23 = (cp(:,5)); % 23.4bar
y_cp_30 = (cp(:,6)); % 30bar
y_cp_40 = (cp(:,7)); % 40bar
y_cp_50 = (cp(:,8)); % 50bar

cp_data = [y_cp_1, y_cp_10, y_cp_20, y_cp_23, y_cp_30, y_cp_40, y_cp_50]; 

cp_T = interp1(x_cp_T, cp_data, T, 'linear','extrap'); % T에 따라서 추출
cp_result = interp1(p, cp_T, P, 'linear','extrap'); % p일 때 결과