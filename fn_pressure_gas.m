function y_query = fn_pressure_gas(x_query, pressure_gas)

% pressure_gas = load('pressure_gas.dat'); % 데이터 불러오기

% 주어진 데이터 포인트
x_known = pressure_gas(:,1);  % x가 0.03 이상인 데이터
y_known = pressure_gas(:,2); % 각 x에 대응하는 y 값

y_query = interp1(x_known, y_known, x_query, 'linear', 'extrap') ;
