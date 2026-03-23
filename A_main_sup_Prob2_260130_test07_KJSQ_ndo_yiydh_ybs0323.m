clc
close all
clear

m_dot_fuel = 0.016; % kg/s
m_dot_gas = 0.958; % kg/s

%%%%% design_1
%%%%% Experiment Condition Initialization 1
dx = 0.001; 

%%% Hx1 Part
L_Hx1 = 0.31; % m, 열교환기의 길이
L_Hx1_start = 0.66; % m, 열교환기 시작위치
n_Hx1 = L_Hx1/dx; % 구간 수

n_fuel_Hx1 = 18; % 채널갯수

W_gas_Hx1 = 100*1e-3; % m
H_gas_Hx1 = 20*1e-3; % m

a_gas_Hx1 = W_gas_Hx1; 
b_gas_Hx1 = H_gas_Hx1; 

D_gas_h_Hx1 = 2*a_gas_Hx1*b_gas_Hx1/(a_gas_Hx1+b_gas_Hx1);

div_ang_Hx1 = 2.0; 
dAdx_Hx1 = W_gas_Hx1*tan(div_ang_Hx1*pi/180);
Area_gas_Hx1 = W_gas_Hx1*H_gas_Hx1 + dAdx_Hx1*dx; 

peri_Hx1 = 2*(W_gas_Hx1+Area_gas_Hx1/W_gas_Hx1); 
dhydro_Hx1 = 4*Area_gas_Hx1/peri_Hx1;

W_ch_Hx1 = 3*1e-3; 
H_ch_Hx1 = 1.33*1e-3;

t_wall_Hx1 = 0.002; % m, 연료와 핫가스 사이 벽 두께
t_ch_Hx1 = 0.001; % [m] 채널사이 간격

D_fuel_h_Hx1 = 2*W_ch_Hx1*H_ch_Hx1/(W_ch_Hx1+H_ch_Hx1); 
Apwc_Hx1 = n_fuel_Hx1*W_ch_Hx1; % area per unit length at fuel side

A_Re_gas_Hx1 = W_gas_Hx1*H_gas_Hx1; 
A_Re_fuel_Hx1 = W_ch_Hx1*H_ch_Hx1; 
Area_fuel_Hx1 = W_ch_Hx1*H_ch_Hx1*n_fuel_Hx1; 

A_heat_gas_Hx1= W_gas_Hx1 * L_Hx1; % wall side, 가스가 닿는 전체면적
A_heat_gas_dx_Hx1 = A_heat_gas_Hx1 *dx; % segment gas area
A_heat_fuel_Hx1 = W_ch_Hx1*n_fuel_Hx1*L_Hx1; % 연료가 닿는 면적
A_heat_fuel_dx_Hx1= W_ch_Hx1*n_fuel_Hx1*dx; % segment fuel area

% 연결배관 1
L_pipe1 = 0.5; 
n_pipe1 = L_pipe1/dx; % 구간 수
d_pipe1 = 0.00635; % 배관 직경 (m), 1/4
num_bends_pipe1 = 4; % 꺾임의 횟수
r_of_bend_pipe1 = d_pipe1 * 2; % 굽은 부분의 반경
A_heat_fuel_pipe1 = d_pipe1*pi*L_pipe1; 
A_heat_fuel_dx_pipe1 = 10*d_pipe1*pi*L_pipe1*dx; 
t_wall_pipe1 = 2.3*1e-3; %[m]
A_Re_fuel_pipe1 = pi*(d_pipe1 /2)^2; 
D_fuel_h_pipe1 = d_pipe1;  
A_Re_gas_pipe1 = 2*A_Re_fuel_pipe1;

%%% Hx2 Part
L_Hx2 = 0.92; % m, 열교환기의 길이
L_Hx2_start = 0.97; % m, 열교환기 시작위치 

n_Hx2 = L_Hx2/dx; % 구간 수
n_fuel_Hx2 = 18; % 채널갯수

W_gas_Hx2 = 100*1e-3; % m
H_gas_Hx2 = 20*1e-3; % m

a_gas_Hx2 = W_gas_Hx2; 
b_gas_Hx2 = H_gas_Hx2; 

D_gas_h_Hx2 = 2*a_gas_Hx2*b_gas_Hx2/(a_gas_Hx2+b_gas_Hx2);

div_ang_Hx2 = 0; 
dAdx_Hx2 = W_gas_Hx2*tan(div_ang_Hx2*pi/180);
Area_gas_Hx2 = W_gas_Hx2*H_gas_Hx2 + dAdx_Hx2*dx; 

peri_Hx2 = 2*(W_gas_Hx2+Area_gas_Hx2/W_gas_Hx2); 
dhydro_Hx2 = 4*Area_gas_Hx2/peri_Hx2;

W_ch_Hx2 = 3*1e-3; 
H_ch_Hx2 = 1.33*1e-3;

t_wall_Hx2 = 0.002; % m, 연료와 핫가스 사이 벽 두께
t_ch_Hx2 = 0.001; % [m] 채널사이 간격

D_fuel_h_Hx2 = 2*W_ch_Hx2*H_ch_Hx2/(W_ch_Hx2+H_ch_Hx2); 
Apwc_Hx2 = n_fuel_Hx2*W_ch_Hx2; % area per unit length at fuel side

A_Re_gas_Hx2 = W_gas_Hx2*H_gas_Hx2; 
A_Re_fuel_Hx2 = W_ch_Hx2*H_ch_Hx2; 
Area_fuel_Hx2 = W_ch_Hx2*H_ch_Hx2*n_fuel_Hx2; 

A_heat_gas_Hx2 = W_gas_Hx2 * L_Hx2; % wall side, 가스가 닿는 전체면적
A_heat_gas_dx_Hx2 = A_heat_gas_Hx2 *dx; % segment gas area
A_heat_fuel_Hx2 = W_ch_Hx2*n_fuel_Hx2*L_Hx2; % 연료가 닿는 면적
A_heat_fuel_dx_Hx2 = W_ch_Hx2*n_fuel_Hx2*dx; % segment fuel area

% 연결배관 2
L_pipe2 = 0.5; 
n_pipe2 = L_pipe1/dx; % 구간 수
d_pipe2 = 0.00635; % 배관 직경 (m), 1/4
num_bends_pipe2 = 4; % 꺾임의 횟수
r_of_bend_pipe2 = d_pipe2 * 2; % 굽은 부분의 반경
A_heat_fuel_dx_pipe2 = 10*d_pipe2*pi*L_pipe2*dx; 
t_wall_pipe2 = 2.3*1e-3; %[m]
A_Re_fuel_pipe2 = pi*(d_pipe2 /2)^2; 
D_fuel_h_pipe2 = d_pipe2;  
A_Re_gas_pipe2 = 2*A_Re_fuel_pipe2;

%%%%% End of design_1

%%%%% Data Reading
KJS = load("KJS.dat");
cp = load("cpf_d2.dat"); 
p = load("pressure_kPa.dat"); % pressure, kPa
akf = load("akf_d2.dat"); 
mu = load("muf_d2.dat"); 
pressure_gas = load('pressure_gas.dat');
rho = load("rhof_d2.dat"); 

%%%%% End of Data Reading


%%%%% Start Main Code.....
R = 287;
T0 = 273; % K
S_gas = 110.4; % sutherland 상수
g = 9.81; %[m/s^2], gravitional acceleration
ambient_temp = 30 + 273.15; % 외부 대기 온도 (K)

% 결과 저장 배열 초기값
T_fuel_Hx1(1) = 30.7+T0;
p_fuel_Hx1(1) = 2250000/1000+200; % [kPa]
p_gas_total = 779092.8; % [Pa]
p_gas_Hx1(1) = 779092.8; % [Pa]
M = 0.02897; % 공기몰질량 [kg/mol]
R_real = 8.314; % 이상기체 상수 [J/(mol\cdotpK)]
Q_total_Hx1(1) = 0; % [W]
q_total_Hx1(1) = 0; % = q_c= q_w
cf_Hx1(1) = 0.00222; % friction coefficient at air inlet
gamma_gas_Hx1(1) = 1.4;
Mach_gas_Hx1(1) = 2;
T_gas_Hx1(1) = 1019.3; %[K]
T_wh_Hx1(1) = 30.7+T0; %[K]
h_Hx1(1) = -1843000; % J/kg
sum_dp_fuel_Hx1(1) = 0;

% the relations for the exponents and turbulent heat transfer coefficeints
N = 7; % reciprocal exponent in velocity profile power law
m = 2/(N+1);
c5 = 2.243 + 0.93*N;
c1 = (1/c5)^(2*N/(N+1))*((N/((N+1)*(N+2)))^m);
c2 = (1+m)*c1;
c3 = 1+m;
c4 = 1/c3;

%%% 계산 시작
tic;
for i = 1 : n_Hx1 + 1
    x_Hx1(i) = L_Hx1_start + dx*(i-1) ;

    p_gas_Hx1(i) = fn_pressure_gas(x_Hx1(i)*1000, pressure_gas);
    q_total_Hx1(i) = fn_qw(x_Hx1(i), KJS)*A_heat_fuel_dx_Hx1;

    % 연료
    rho_fuel_Hx1(i) = fn_rho_find(T_fuel_Hx1(i), p_fuel_Hx1(i), rho, p);
    u_fuel_Hx1(i) = m_dot_fuel / (rho_fuel_Hx1(i) * A_Re_fuel_Hx1 * n_fuel_Hx1);
    svolf_Hx1(i) = 1/rho_fuel_Hx1(i);
    svolf1_Hx1(i) = 1/fn_rho_find(T_fuel_Hx1(i)+1, p_fuel_Hx1(i), rho, p);
    beta_Hx1(i) = rho_fuel_Hx1(i)*(svolf1_Hx1(i) - svolf_Hx1(i)); % volumetric thermal expansion coefficient
    Cp_fuel_Hx1(i) = fn_Cp_find(T_fuel_Hx1(i), p_fuel_Hx1(i), cp, p);
    k_fuel_Hx1(i) = fn_kf_find(T_fuel_Hx1(i), p_fuel_Hx1(i), akf, p);
    mu_fuel_Hx1(i) = fn_mu_find(T_fuel_Hx1(i), p_fuel_Hx1(i), mu, p)*1e-6;
    Pr_fuel_Hx1(i) = Cp_fuel_Hx1(i) * mu_fuel_Hx1(i) / k_fuel_Hx1(i);
    Re_fuel_Hx1(i) = rho_fuel_Hx1(i) * u_fuel_Hx1(i) * D_fuel_h_Hx1/ (mu_fuel_Hx1(i));

    if i == 1
        k_wall_Hx1(i) = (0.01571*T_wh_Hx1(i) + 9.248); % 가스

        if Re_fuel_Hx1(i) < 2000
            % 층류 입구효과를 고려한 코드 작성
            f_fuel_Hx1(i) = 64/Re_fuel_Hx1(i);
            Nu_fuel_Hx1(i) = 3.66;

        elseif (2000 <= Re_fuel_Hx1(i)) && (Re_fuel_Hx1(i) < 100000)
            f_fuel_Hx1(i) = 0.316*Re_fuel_Hx1(i)^(-0.25);
            Nu_fuel_Hx1(i) = 0.023 * (Re_fuel_Hx1(i)^0.8) * (Pr_fuel_Hx1(i)^0.4);

        else
            f_fuel_Hx1(i) = 0.0032 + 0.221*Re_fuel_Hx1(i)^(-0.237);
            Nu_fuel_Hx1(i) = 0.023 * (Re_fuel_Hx1(i)^0.8) * (Pr_fuel_Hx1(i)^0.4);

        end

        h_fuel_Hx1(i) = Nu_fuel_Hx1(i) * k_fuel_Hx1(i) / D_fuel_h_Hx1; % 열전달계수 W/m2 K
        xi_Hx1(i) = sqrt(2*h_fuel_Hx1(i)*t_ch_Hx1/k_wall_Hx1(i)) * H_ch_Hx1/t_ch_Hx1; % 크사이, 핀효율 구할 때 필요한 값
        eff_fin_Hx1(i) = W_ch_Hx1/(W_ch_Hx1+t_ch_Hx1)+2*H_ch_Hx1/(W_ch_Hx1+t_ch_Hx1)*tanh(xi_Hx1(i))/xi_Hx1(i);
        h_f_Hx1(i) = h_fuel_Hx1(i)*eff_fin_Hx1(i);
        U_Hx1(i) = 1 / ((t_wall_Hx1 / k_wall_Hx1(i)) + (1 / h_f_Hx1(i))); % htotal
        T_wc_Hx1(i) =  T_fuel_Hx1(i) + q_total_Hx1(i)/(h_f_Hx1(i)*A_heat_fuel_dx_Hx1);
        T_wh_Hx1(i) = T_wc_Hx1(i) + q_total_Hx1(i)*t_wall_Hx1/(k_wall_Hx1(i)*A_heat_fuel_dx_Hx1);

        %%% 판별
    else
        k_wall_Hx1(i) = (0.01571*T_wh_Hx1(i-1) + 9.248);
        Pr_fuel_Hx1(i) = Cp_fuel_Hx1(i) * mu_fuel_Hx1(i) / k_fuel_Hx1(i);

        if Re_fuel_Hx1(i) < 2000
            f_fuel_Hx1(i) = 64/Re_fuel_Hx1(i);
            Nu_fuel_Hx1(i) = 3.66 ;

        elseif (2000 <= Re_fuel_Hx1(i)) && (Re_fuel_Hx1(i) < 100000)
            f_fuel_Hx1(i) = 0.316*Re_fuel_Hx1(i)^(-0.25); % white eq. 6.39
            Nu_fuel_Hx1(i) = 0.023 * (Re_fuel_Hx1(i)^0.8) * (Pr_fuel_Hx1(i)^0.4);

        else
            f_fuel_Hx1(i) = 0.0032 + 0.221*Re_fuel_Hx1(i)^(-0.237); % white eq. 6.39
            Nu_fuel_Hx1(i) = 0.023 * (Re_fuel_Hx1(i)^0.8) * (Pr_fuel_Hx1(i)^0.4);
        end

        % 연료
        k_fuel_Hx1(i) = fn_kf_find(T_fuel_Hx1(i), p_fuel_Hx1(i), akf, p);
        h_fuel_Hx1(i) = Nu_fuel_Hx1(i) * k_fuel_Hx1(i) / D_fuel_h_Hx1; % 열전달계수 W/m2 K
        xi_Hx1(i) = sqrt(2*h_fuel_Hx1(i)*t_ch_Hx1/k_wall_Hx1(i)) * H_ch_Hx1/t_ch_Hx1; % 크사이, 핀효율 구할 때 필요한 값
        eff_fin_Hx1(i) = W_ch_Hx1/(W_ch_Hx1+t_ch_Hx1)+2*H_ch_Hx1/(W_ch_Hx1+t_ch_Hx1)*tanh(xi_Hx1(i))/xi_Hx1(i);
        h_f_Hx1(i) = h_fuel_Hx1(i)*eff_fin_Hx1(i);
        U_Hx1(i) = 1 / ((t_wall_Hx1 / k_wall_Hx1(i)) + (1 / h_f_Hx1(i))); % htotal

        % 가스
        T_wc_Hx1(i) =  T_fuel_Hx1(i) + q_total_Hx1(i)/(h_f_Hx1(i)*A_heat_fuel_dx_Hx1);
        T_wh_Hx1(i) = T_wc_Hx1(i) + q_total_Hx1(i)*t_wall_Hx1/(k_wall_Hx1(i)*A_heat_fuel_dx_Hx1);

    end

    Q_total_Hx1(i+1) = q_total_Hx1(i) + Q_total_Hx1(i);

    fricpf_Hx1(i+1) = n_fuel_Hx1*pi/8*f_fuel_Hx1(i)*rho_fuel_Hx1(i)*u_fuel_Hx1(i)^2*D_fuel_h_Hx1;
    qpp_Hx1(i+1) = (q_total_Hx1(i)/dx)/(W_ch_Hx1*n_fuel_Hx1); % heat addition per unit length
    qp_Hx1(i+1) = u_fuel_Hx1(i)*fricpf_Hx1(i+1)+Apwc_Hx1*qpp_Hx1(i+1);
    drfdp_Hx1(i+1) = ( fn_rho_find(T_fuel_Hx1(i), p_fuel_Hx1(i)+100, rho, p) - fn_rho_find(T_fuel_Hx1(i), p_fuel_Hx1(i), rho, p) )/100000;
    drfdT_Hx1(i+1) = ( fn_rho_find(T_fuel_Hx1(i)+20, p_fuel_Hx1(i), rho, p) - fn_rho_find(T_fuel_Hx1(i), p_fuel_Hx1(i), rho, p) )/20;

    dTdxf_Hx1(i+1) = -1*beta_Hx1(i)*T_fuel_Hx1(i)*fricpf_Hx1(i+1) / (rho_fuel_Hx1(i)*Cp_fuel_Hx1(i)*(1+u_fuel_Hx1(i)^2*drfdp_Hx1(i+1))*Area_fuel_Hx1) + qp_Hx1(i+1)/m_dot_fuel/Cp_fuel_Hx1(i);
    dTdxf_Hx1(i+1) = dTdxf_Hx1(i+1)/(1+beta_Hx1(i)*T_fuel_Hx1(i)*drfdT_Hx1(i+1)*u_fuel_Hx1(i)^2/rho_fuel_Hx1(i)/Cp_fuel_Hx1(i)/(1+u_fuel_Hx1(i)^2*drfdp_Hx1(i+1)));
    dpdxf_Hx1(i+1) = (-1*u_fuel_Hx1(i)^2*drfdT_Hx1(i+1)*dTdxf_Hx1(i+1) - fricpf_Hx1(i+1)/Area_fuel_Hx1)/(1+u_fuel_Hx1(i)^2*drfdp_Hx1(i+1));
    drhodxf_Hx1(i+1) = drfdp_Hx1(i+1)*dpdxf_Hx1(i+1) +drfdT_Hx1(i+1)*dTdxf_Hx1(i+1);
    % dudxf_Hx1(i+1) = -1*u_fuel_Hx1(i)/rho_fuel_Hx1(i)*drhodxf_Hx1(i+1);

    dh_Hx1(i+1) = (beta_Hx1(i)*T_fuel_Hx1(i)/rho_fuel_Hx1(i)*dpdxf_Hx1(i+1)+dTdxf_Hx1(i+1)*Cp_fuel_Hx1(i))*dx;
    h_Hx1(i+1) = dh_Hx1(i+1) + h_Hx1(i);
    dT_Hx1(i+1) = 0.5*dh_Hx1(i+1) / Cp_fuel_Hx1(i) / max(h_Hx1(i+1)/h_Hx1(i), h_Hx1(i)/h_Hx1(i+1));
    T_fuel_iter_Hx1(i+1) = T_fuel_Hx1(i) + dT_Hx1(i+1);
    
    Cp_fuel_iter_Hx1(i+1) = fn_Cp_find(T_fuel_iter_Hx1(i+1), p_fuel_Hx1(i), cp, p);
    h_iter_Hx1(i+1) = h_Hx1(i) + (Cp_fuel_Hx1(i) + Cp_fuel_iter_Hx1(i+1))/ 2 * dT_Hx1(i+1);
    tol_Hx1(i+1) = abs((h_Hx1(i+1) - h_iter_Hx1(i+1)) / h_Hx1(i+1));

    % Iteration Code (Revised)
    Iter = 1;
    tol_Hx_1 = tol_Hx1(i+1);
    dh_Hx1_1 = dh_Hx1(i+1);

    if tol_Hx1(Iter) > 1e-8
        dT_iter = 0.5*dh_Hx1_1 / Cp_fuel_Hx1(i) / max(h_Hx1(i+1)/h_Hx1(i), h_Hx1(i)/h_Hx1(i+1));
        T_fuel_iter_Hx1(Iter) = T_fuel_Hx1(i) + dT_Hx1(i+1);
        Cp_fuel_iter_Hx1(Iter) = fn_Cp_find(T_fuel_iter_Hx1(i+1), p_fuel_Hx1(i), cp, p);
        h_iter_Hx1(Iter) = h_Hx1(i) + (Cp_fuel_Hx1(i) + Cp_fuel_iter_Hx1(i+1))/ 2 * dT_iter;
        tol_Hx1(Iter) = abs((h_Hx1(i+1) - h_iter_Hx1(Iter)) / h_Hx1(i+1));

    else
        T_fuel_Hx1(i+1) = T_fuel_iter_Hx1(Iter);

        Iter = Iter + 1;
    end

    T_fuel_Hx1(i+1) = T_fuel_iter_Hx1(Iter);
    % End of Iteration Code (Revised)

    % % Iteration Code (Existed)
    % Iter = 1;
    % tol_Hx1(Iter) = tol_Hx1(i+1);
    % dh_Hx1_1 = dh_Hx1(i+1);
    % 
    % if tol_Hx1(Iter) > 1e-8
    %     dT_iter(Iter) = 0.5*dh_Hx1_1 / Cp_fuel_Hx1(i) / max(h_Hx1(i+1)/h_Hx1(i), h_Hx1(i)/h_Hx1(i+1));
    %     T_fuel_iter_Hx1(Iter) = T_fuel_Hx1(i) + dT_Hx1(i+1);
    %     Cp_fuel_iter_Hx1(Iter) = fn_Cp_find(T_fuel_iter_Hx1(i+1), p_fuel_Hx1(i), cp, p);
    %     h_iter_Hx1(Iter) = h_Hx1(i) + (Cp_fuel_Hx1(i) + Cp_fuel_iter_Hx1(i+1))/ 2 * dT_Hx1(i+1);
    %     tol_Hx1(Iter) = abs((h_Hx1(i+1) - h_iter_Hx1(i+1)) / h_Hx1(i+1));
    % 
    % else
    %     T_fuel_Hx1(i+1) = T_fuel_iter_Hx1(Iter);
    % 
    %     Iter = Iter + 1;
    % end
    % 
    % T_fuel_Hx1(i+1) = T_fuel_iter_Hx1(Iter);
    % % End of Iteration Code (Existed)
    
    dp_fuel_Hx1(i+1) = (f_fuel_Hx1(i)*(dx/D_fuel_h_Hx1)*rho_fuel_Hx1(i)*((u_fuel_Hx1(i)^2)/2))/1000;
    p_fuel_Hx1(i+1) = p_fuel_Hx1(i) - dp_fuel_Hx1(i+1);
    sum_dp_fuel_Hx1(i+1) = sum_dp_fuel_Hx1(i) + dp_fuel_Hx1(i+1);

end

fprintf(' --- "Hx1 완료" ---  \n\n' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pipe 1 자연대류
h_gas_air = 20; % 대류 열전달 계수 (W/m²·K)
p_atm = 101325; %[Pa]
Pr_air = 0.71;
T_fuel_pipe1 = T_fuel_Hx1(n_Hx1+1); % 배관입구 연료온도 (K)

for ii = 1 : n_pipe1+1
    x_pipe1(ii) = dx*(ii-1);
    p_fuel_pipe1(ii) = p_fuel_Hx1(i);
    T_gas_pipe1(ii) = ambient_temp; % 연결배관 대기온도 (K)
    rho_fuel_pipe1(ii) = fn_rho_find(T_fuel_pipe1(ii), p_fuel_pipe1(ii), rho, p);
    h_gas_pipe1(ii) = h_gas_air;
    k_fuel_pipe1(ii) = fn_kf_find(T_fuel_pipe1(ii), p_fuel_pipe1(ii), akf, p);
    Pr_gas_pipe1(ii) = Pr_air;
    Nu_gas_pipe1(ii) = 3.66;

    if ii == 1
        T_fuel_pipe1(ii) = T_fuel_Hx1(i); % 배관입구 연료온도 (K)
        rho_gas_pipe1(ii) = p_atm*M/R/T_gas_pipe1(ii);
        mu_gas_pipe1(ii) = 1.716e-5*((T_gas_pipe1(ii)/T0)^(3/2))*(T0+S_gas)/(T_gas_pipe1(ii)+S_gas);
        u_gas_pipe1(ii) = m_dot_gas / (rho_gas_pipe1(ii) * A_Re_gas_pipe1);
        Re_gas_pipe1(ii) = 2300;
        Cp_fuel_pipe1(ii) = fn_Cp_find(T_fuel_pipe1(ii), p_fuel_pipe1(ii), cp, p);
        T_wh_pipe1(ii) = ambient_temp;
        k_wall_pipe1(ii) = (0.01571*T_wh_pipe1(ii) + 9.248);
        mu_fuel_pipe1(ii) = fn_mu_find(T_fuel_pipe1(ii), p_fuel_pipe1(ii), mu, p)*1e-6;
        u_fuel_pipe1(ii) = m_dot_fuel / (rho_fuel_pipe1(ii) * A_Re_fuel_pipe1);
        Re_fuel_pipe1(ii) = rho_fuel_pipe1(ii) * u_fuel_pipe1(ii) * D_fuel_h_pipe1/ (mu_fuel_pipe1(ii));
        Pr_fuel_pipe1(ii) = Cp_fuel_pipe1(ii) * mu_fuel_pipe1(ii) / k_fuel_pipe1(ii);

        % 연료
        if Re_fuel_pipe1(ii) < 2000
            f_fuel_pipe1(ii) = 64/Re_fuel_pipe1(ii);
            Nu_fuel_pipe1(ii) = 0.023*(Re_fuel_pipe1(ii)^0.8)*(Pr_fuel_pipe1(ii)^0.4) ;

        elseif (2000 <= Re_fuel_pipe1(ii)) && (Re_fuel_pipe1(ii) < 100000)
            f_fuel_pipe1(ii) = 0.1364*(Re_fuel_pipe1(ii)^(-0.25));
            Nu_fuel_pipe1(ii) = 0.023*(Re_fuel_pipe1(ii)^0.8)*(Pr_fuel_pipe1(ii)^0.4) ;

        else
            f_fuel_pipe1(ii) = 0.0032+0.221*(Re_fuel_pipe1(ii)^(-0.237));
            Nu_fuel_pipe1(ii) = 0.023*(Re_fuel_pipe1(ii)^0.8)*(Pr_fuel_pipe1(ii)^0.4) ;

        end

        k_fuel_pipe1(ii) = fn_kf_find(T_fuel_pipe1(ii), p_fuel_pipe1(ii), akf, p);
        h_f_pipe1(ii) = Nu_fuel_pipe1(ii) * k_fuel_pipe1(ii) / D_fuel_h_pipe1; % 열전달계수 W/m2 K
        U_pipe1(ii) = 1 / ((1 / h_gas_pipe1(ii)) + (t_wall_pipe1 / k_wall_pipe1(ii)) + (1 / h_f_pipe1(ii))); % htotal
        q_total_pipe1(ii) = U_pipe1(ii)*A_heat_fuel_dx_pipe1*(T_gas_pipe1(ii)-T_fuel_pipe1(ii)); % 단위 총 열전달량
        T_wc_pipe1(ii) = T_fuel_pipe1(ii) + q_total_pipe1(ii)/(A_heat_fuel_dx_pipe1*h_f_pipe1(ii));
        T_wh_pipe1(ii) = T_wc_pipe1(ii) + q_total_pipe1(ii)*t_wall_pipe1/k_wall_pipe1(ii)/(A_heat_fuel_dx_pipe1);

    else 
        rho_gas_pipe1(ii) = p_atm*M/R/T_gas_pipe1(ii);
        mu_gas_pipe1(ii) = 1.716e-5*((T_gas_pipe1(ii)/T0)^(3/2))*(T0+S_gas)/(T_gas_pipe1(ii)+S_gas);
        u_gas_pipe1(ii) = m_dot_gas / (rho_gas_pipe1(ii) * A_Re_gas_pipe1);
        Re_gas_pipe1(ii) = 2300;
        Cp_fuel_pipe1(ii) = fn_Cp_find(T_fuel_pipe1(ii), p_fuel_pipe1(ii), cp, p);
        k_wall_pipe1(ii) = (0.01571*T_wh_pipe1(ii-1) + 9.248);
        mu_fuel_pipe1(ii) = fn_mu_find(T_fuel_pipe1(ii), p_fuel_pipe1(ii), mu, p);
        u_fuel_pipe1(ii) = m_dot_fuel / (rho_fuel_pipe1(ii) * A_Re_fuel_pipe1);
        Re_fuel_pipe1(ii) = rho_fuel_pipe1(ii) * u_fuel_pipe1(ii) * D_fuel_h_pipe1/ (mu_fuel_pipe1(ii));
        Pr_fuel_pipe1(ii) = Cp_fuel_pipe1(ii) * mu_fuel_pipe1(ii) / k_fuel_pipe1(ii);

        % 연료
        if Re_fuel_pipe1(ii) < 2000
            f_fuel_pipe1(ii) = 64/Re_fuel_pipe1(ii);
            Nu_fuel_pipe1(ii) = 0.023*(Re_fuel_pipe1(ii)^0.8)*(Pr_fuel_pipe1(ii)^0.4);

        elseif (2000 <= Re_fuel_pipe1(ii)) && (Re_fuel_pipe1(ii) < 100000)
            f_fuel_pipe1(ii) = 0.1364*(Re_fuel_pipe1(ii)^(-0.25));
            Nu_fuel_pipe1(ii) = 0.023*(Re_fuel_pipe1(ii)^0.8)*(Pr_fuel_pipe1(ii)^0.4) ;

        else
            f_fuel_pipe1(ii) = 0.0032+0.221*(Re_fuel_pipe1(ii)^(-0.237));
            Nu_fuel_pipe1(ii) = 0.023*(Re_fuel_pipe1(ii)^0.8)*(Pr_fuel_pipe1(ii)^0.4) ;

        end

        h_f_pipe1(ii) = Nu_fuel_pipe1(ii) * k_fuel_pipe1(ii) / D_fuel_h_pipe1; % 열전달계수 W/m2 K
        U_pipe1(ii) = 1 / ((1 / h_gas_pipe1(ii)) + (t_wall_pipe1 / k_wall_pipe1(ii)) + (1 / h_f_pipe1(ii))); % htotal
        q_total_pipe1(ii) = U_pipe1(ii)*A_heat_fuel_dx_pipe1*(T_fuel_pipe1(ii)-T_gas_pipe1(ii)); % 단위 총 열전달량
        T_wc_pipe1(ii) = T_fuel_pipe1(ii) + q_total_pipe1(ii)/(A_heat_fuel_dx_pipe1*h_f_pipe1(ii));
        T_wh_pipe1(ii) = T_wc_pipe1(ii) + q_total_pipe1(ii)*t_wall_pipe1/k_wall_pipe1(ii)/(A_heat_fuel_dx_pipe1);
    end

    T_fuel_pipe1(ii+1) = T_fuel_pipe1(ii) - q_total_pipe1(ii) / (Cp_fuel_pipe1(ii) * m_dot_fuel);
end


fprintf(' --- "Pipe1 완료" --- \n\n' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Hx2
Q_total_Hx2(1) = 0;
T_fuel_Hx2(1) = T_fuel_pipe1(n_pipe1+1);
p_fuel_Hx2(1) = p_fuel_pipe1(n_pipe1+1);
h_Hx2(1) = h_Hx1(i-1);
sum_dp_fuel_Hx2(1) = sum_dp_fuel_Hx1(i-1);

% 계산 시작
for j = 1 : n_Hx2 + 1
    x_Hx2(j) = L_Hx2_start - dx*(j-1);

    p_gas_Hx2(j) = fn_pressure_gas(x_Hx2(j)*1000, pressure_gas);
    T_wh_Hx2(1) = T_wh_Hx1(i-1);
    q_total_Hx2(j) = fn_qw(x_Hx2(j), KJS)*A_heat_fuel_dx_Hx2;

    % 연료
    rho_fuel_Hx2(j) = fn_rho_find(T_fuel_Hx2(j), p_fuel_Hx2(j), rho, p);
    u_fuel_Hx2(j) = m_dot_fuel / (rho_fuel_Hx2(j) * A_Re_fuel_Hx2 * n_fuel_Hx2);
    svolf_Hx2(j) = 1/rho_fuel_Hx2(j);
    svolf1_Hx2(j) = 1/fn_rho_find(T_fuel_Hx2(j)+1, p_fuel_Hx2(j), rho, p);
    beta_Hx2(j) = rho_fuel_Hx2(j)*(svolf1_Hx2(j) - svolf_Hx2(j)); % volumetric thermal expansion coefficient
    Cp_fuel_Hx2(j) = fn_Cp_find(T_fuel_Hx2(j), p_fuel_Hx2(j), cp, p);
    k_fuel_Hx2(j) = fn_kf_find(T_fuel_Hx2(j), p_fuel_Hx2(j), akf, p);
    mu_fuel_Hx2(j) = fn_mu_find(T_fuel_Hx2(j), p_fuel_Hx2(j), mu, p)*1e-6;
    Pr_fuel_Hx2(j) = Cp_fuel_Hx2(j) * mu_fuel_Hx2(j) / k_fuel_Hx2(j);
    Re_fuel_Hx2(j) = rho_fuel_Hx2(j) * u_fuel_Hx2(j) * D_fuel_h_Hx2/ (mu_fuel_Hx2(j));

    if j == 1
        % 가스
        if Re_fuel_Hx2(j) < 2300
            % 층류 입구효과 고려
            if x_Hx2(j) <= 0.05*Re_fuel_Hx2(j)*Pr_fuel_Hx2(j)*D_fuel_h_Hx2
                f_fuel_Hx2(j) = 0.42*(1-(W_ch_Hx2/(W_ch_Hx2+t_ch_Hx2))^2)*D_fuel_h_Hx2/(x_Hx2(j)+dx);
                Nu_fuel_Hx2(j) = 3.66 + 0.0668*(D_fuel_h_Hx2/(x_Hx2(j)+0.5*dx))*Re_fuel_Hx2(j)*Pr_fuel_Hx2(j)/(1+0.04*((D_fuel_h_Hx2/(x_Hx2(j)+0.5*dx))*Re_fuel_Hx2(j)*Pr_fuel_Hx2(j))^(2/3)); % yiy

            else
                f_fuel_Hx2(j) = 64/Re_fuel_Hx2(j);
                Nu_fuel_Hx2(j) = 3.66 ;

            end

        else
            f_fuel_Hx2(j) = 0.316*Re_fuel_Hx2(j)^(-0.25); % white eq. 6.39
            Nu_fuel_Hx2(j) = 150;

        end

        k_wall_Hx2(j) = (0.01571*T_wh_Hx2(j) + 9.248);
        h_fuel_Hx2(j) = Nu_fuel_Hx2(j) * k_fuel_Hx2(j) / D_fuel_h_Hx2; % 열전달계수 W/m2 K
        xi_Hx2(j) = sqrt(2*h_fuel_Hx2(j)*t_ch_Hx1/k_wall_Hx2(j)) * H_ch_Hx2/t_ch_Hx2; % 크사이, 핀효율 구할 때 필요한 값
        eff_fin_Hx2(j) = W_ch_Hx2/(W_ch_Hx2+t_ch_Hx2)+2*H_ch_Hx2/(W_ch_Hx2+t_ch_Hx2)*tanh(xi_Hx2(j))/xi_Hx2(j);
        h_f_Hx2(j) = h_fuel_Hx2(j)*eff_fin_Hx2(j);
        U_Hx2(j) = 1 / ((t_wall_Hx1 / k_wall_Hx2(j)) + (1 / h_f_Hx2(j))); % htotal
        T_wc_Hx2(j) =  T_fuel_Hx2(j) + q_total_Hx2(j)/(h_f_Hx2(j)*A_heat_fuel_dx_Hx2);
        T_wh_Hx2(j) = T_wc_Hx2(j) + q_total_Hx2(j)*t_wall_Hx2/(k_wall_Hx2(j)*A_heat_fuel_dx_Hx2);

    else
        svolf_Hx2(j) = 1/rho_fuel_Hx2(j);
        svolf1_Hx2(j) = 1/fn_rho_find(T_fuel_Hx2(j)+1, p_fuel_Hx2(j), rho, p);
        beta_Hx2(j) = rho_fuel_Hx2(j)*(svolf1_Hx2(j) - svolf_Hx2(j)); % volumetric thermal expansion coefficient
        k_fuel_Hx2(j) = fn_kf_find(T_fuel_Hx2(j), p_fuel_Hx2(j), akf, p);
        k_wall_Hx2(j) = (0.01571*T_wh_Hx2(j-1) + 9.248);

        if Re_fuel_Hx2(j) < 2300
            % 층류 입구효과 고려
            if x_Hx2(j) <= 0.05*Re_fuel_Hx2(j)*Pr_fuel_Hx2(j)*D_fuel_h_Hx1
                f_fuel_Hx2(j) = 0.42*(1-(W_ch_Hx2/(W_ch_Hx2+t_ch_Hx2))^2)*D_fuel_h_Hx2/(x_Hx2(j)+dx);
                Nu_fuel_Hx2(j) = 3.66 + 0.0668*(D_fuel_h_Hx2/(x_Hx2(j)+0.5*dx))*Re_fuel_Hx2(j)*Pr_fuel_Hx2(j)/(1+0.04*((D_fuel_h_Hx2/(x_Hx2(j)+0.5*dx))*Re_fuel_Hx2(j)*Pr_fuel_Hx2(j))^(2/3)); % yiy

            else
                f_fuel_Hx2(j) = 64/Re_fuel_Hx2(j);
                Nu_fuel_Hx2(j) = 3.66;

            end

        else
            f_fuel_Hx2(j) = 0.316*Re_fuel_Hx2(j)^(-0.25);
            Nu_fuel_Hx2(j) = ((f_fuel_Hx2(j) / 8) * (Re_fuel_Hx2(j) - 1000) * Pr_fuel_Hx2(j)) / (1 + 12.7 * sqrt(f_fuel_Hx2(j) / 8) * (Pr_fuel_Hx2(j)^(2/3) - 1));

        end

        % 연료
        k_fuel_Hx2(j) = fn_kf_find(T_fuel_Hx2(j), p_fuel_Hx2(j), akf, p);
        h_fuel_Hx2(j) = Nu_fuel_Hx2(j) * k_fuel_Hx2(j) / D_fuel_h_Hx1; % 열전달계수 W/m2 K
        xi_Hx2(j) = sqrt(2*h_fuel_Hx2(j)*t_ch_Hx1/k_wall_Hx2(j)) * H_ch_Hx1/t_ch_Hx1; % 크사이, 핀효율 구할 때 필요한 값
        eff_fin_Hx2(j) = W_ch_Hx1/(W_ch_Hx1+t_ch_Hx1)+2*H_ch_Hx1/(W_ch_Hx1+t_ch_Hx1)*tanh(xi_Hx2(j))/xi_Hx2(j);
        h_f_Hx2(j) = h_fuel_Hx2(j)*eff_fin_Hx2(j);
        U_Hx2(j) = 1 / ((t_wall_Hx1 / k_wall_Hx2(j)) + (1 / h_f_Hx2(j))); % htotal

        % 가스
        T_wc_Hx2(j) =  T_fuel_Hx2(j) + q_total_Hx2(j)/(h_f_Hx2(j)*A_heat_fuel_dx_Hx2);
        T_wh_Hx2(j) = T_wc_Hx2(j) + q_total_Hx2(j)*t_wall_Hx2/(k_wall_Hx2(j)*A_heat_fuel_dx_Hx2);

    end

    Q_total_Hx2(j+1) = q_total_Hx2(j) + Q_total_Hx2(j);

    fricpf_Hx2(j+1) = n_fuel_Hx2*pi/8*f_fuel_Hx2(j)*rho_fuel_Hx2(j)*u_fuel_Hx2(j)^2*D_fuel_h_Hx2;
    qpp_Hx2(j+1) = (q_total_Hx2(j)/dx)/(W_ch_Hx2*n_fuel_Hx2); % heat addition per unit length
    qp_Hx2(j+1) = u_fuel_Hx2(j)*fricpf_Hx2(j+1)+Apwc_Hx1*qpp_Hx2(j+1);
    drfdp_Hx2(j+1) = ( fn_rho_find(T_fuel_Hx2(j), p_fuel_Hx2(j)+100, rho, p) - fn_rho_find(T_fuel_Hx2(j), p_fuel_Hx2(j), rho, p) )/100000;
    drfdT_Hx2(j+1) = ( fn_rho_find(T_fuel_Hx2(j)+20, p_fuel_Hx2(j), rho, p) - fn_rho_find(T_fuel_Hx2(j), p_fuel_Hx2(j), rho, p) )/20;

    dTdxf_Hx2(j+1) = -1*beta_Hx2(j)*T_fuel_Hx2(j)*fricpf_Hx2(j+1) / (rho_fuel_Hx2(j)*Cp_fuel_Hx2(j)*(1+u_fuel_Hx2(j)^2*drfdp_Hx2(j+1))*Area_fuel_Hx2) + qp_Hx2(j+1)/m_dot_fuel/Cp_fuel_Hx2(j);
    dTdxf_Hx2(j+1) = dTdxf_Hx2(j+1)/(1+beta_Hx2(j)*T_fuel_Hx2(j)*drfdT_Hx2(j+1)*u_fuel_Hx2(j)^2/rho_fuel_Hx2(j)/Cp_fuel_Hx2(j)/(1+u_fuel_Hx2(j)^2*drfdp_Hx2(j+1)));
    dpdxf_Hx2(j+1) = (-1*u_fuel_Hx2(j)^2*drfdT_Hx2(j+1)*dTdxf_Hx2(j+1) - fricpf_Hx2(j+1)/Area_fuel_Hx1)/(1+u_fuel_Hx2(j)^2*drfdp_Hx2(j+1));

    % T_fuel_Hx2(j+1) = T_fuel_Hx2(j)+dTdxf_Hx2(j+1)*dx;

    dh_Hx2(j+1) = (beta_Hx2(j)*T_fuel_Hx2(j)/rho_fuel_Hx2(j)*dpdxf_Hx2(j+1)+dTdxf_Hx2(j+1)*Cp_fuel_Hx2(j))*dx;
    h_Hx2(j+1) = dh_Hx2(j+1) + h_Hx2(j);
    dT_Hx2(j+1) = 0.5*dh_Hx2(j+1) / Cp_fuel_Hx2(j) / max(h_Hx2(j+1)/h_Hx2(j), h_Hx2(j)/h_Hx2(j+1));
    T_fuel_iter_Hx2(j+1) = T_fuel_Hx2(j) + dT_Hx2(j+1);
    Cp_fuel_iter_Hx2(j+1) = fn_Cp_find(T_fuel_iter_Hx2(j+1), p_fuel_Hx2(j), cp, p);
    h_iter_Hx2(j+1) = h_Hx2(j) + (Cp_fuel_Hx2(j) + Cp_fuel_iter_Hx2(j+1))/ 2 * dT_Hx2(j+1);
    tol_Hx2(j+1) = abs((h_Hx2(j+1) - h_iter_Hx2(j+1)) / h_Hx2(j+1));
    Iter = 1;
    tol_Hx2(Iter) = tol_Hx2(j+1);
    dh_Hx2_1 = dh_Hx2(j+1);

    if tol_Hx2(Iter) > 1e-8
        dT_iter_Hx2(Iter) = 0.5*dh_Hx2_1 / Cp_fuel_Hx2(j) / max(h_Hx2(j+1)/h_Hx2(j), h_Hx2(j)/h_Hx2(j+1));
        T_fuel_iter_Hx2(Iter) = T_fuel_Hx2(j) + dT_Hx2(j+1);
        Cp_fuel_iter_Hx2(Iter) = fn_Cp_find(T_fuel_iter_Hx2(j+1), p_fuel_Hx2(j), cp, p);
        h_iter_Hx2(Iter) = h_Hx2(j) + (Cp_fuel_Hx2(j) + Cp_fuel_iter_Hx2(j+1))/ 2 * dT_Hx2(j+1);
        tol_Hx2(Iter) = abs((h_Hx2(j+1) - h_iter_Hx2(j+1)) / h_Hx2(j+1));

    else
        T_fuel_Hx2(j+1) = T_fuel_iter_Hx2(Iter);

        Iter = Iter + 1;
    end

    T_fuel_Hx2(j+1) = T_fuel_iter_Hx2(Iter);
    dp_fuel_Hx2(j+1) = (f_fuel_Hx2(j)*(dx/D_fuel_h_Hx2)*rho_fuel_Hx2(j)*((u_fuel_Hx2(j)^2)/2))/1000;
    p_fuel_Hx2(j+1) = p_fuel_Hx2(j) - dp_fuel_Hx2(j+1);
    sum_dp_fuel_Hx2(j+1) = sum_dp_fuel_Hx2(j) + dp_fuel_Hx2(j+1);

end

fprintf(' --- "Hx2 완료" --- \n\n' );
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% pipe 2 자연대류
T_fuel_pipe2(1) = T_fuel_Hx2(j); % 배관입구온도 (K)
ambient_temp = 30 + 273.15; % 외부 대기 온도 (K)
h_gas_air = 20; % 대류 열전달 계수 (W/m²·K)
p_atm = 101325; %[Pa]
Pr_air = 0.71;

for jj = 1 : n_pipe2+1
    x_pipe2(jj) = dx*(jj-1);
    p_fuel_pipe2(jj) = p_fuel_Hx2(j);
    T_gas_pipe2(jj) = ambient_temp; % 연결배관 대기온도 (K)
    rho_fuel_pipe2(jj) = fn_rho_find(T_fuel_pipe2(jj), p_fuel_pipe2(jj), rho, p);
    h_gas_pipe2(jj) = h_gas_air;
    k_fuel_pipe2(jj) = fn_kf_find(T_fuel_pipe2(jj), p_fuel_pipe2(jj), akf, p);
    Pr_gas_pipe2(jj) = Pr_air;
    Nu_gas_pipe2(jj) = 3.66;

    if jj == 1
        T_fuel_pipe2(jj) = T_fuel_Hx2(n_Hx2+1); % 배관입구 연료온도 (K)
        rho_gas_pipe2(jj) = p_atm*M/R/T_gas_pipe2(jj);
        mu_gas_pipe2(jj) = 1.716e-5*((T_gas_pipe2(jj)/T0)^(3/2))*(T0+S_gas)/(T_gas_pipe2(jj)+S_gas);
        u_gas_pipe1(jj) = m_dot_gas / (rho_gas_pipe1(jj) * A_Re_gas_pipe1);
        T_wh_pipe2(jj) = ambient_temp;
        Re_gas_pipe1(ii) = 2300;
        Cp_fuel_pipe2(jj) = fn_Cp_find(T_fuel_pipe2(jj), p_fuel_pipe2(jj), cp, p);
        k_wall_pipe2(jj) = (0.0158*T_wh_pipe2(jj) + 9.1661);
        mu_fuel_pipe2(jj) = fn_mu_find(T_fuel_pipe2(jj), p_fuel_pipe2(jj), mu, p)*1e-6;
        u_fuel_pipe2(jj) = m_dot_fuel / (rho_fuel_pipe2(jj) * A_Re_fuel_pipe1);
        Re_fuel_pipe2(jj) = rho_fuel_pipe2(jj) * u_fuel_pipe2(jj) * D_fuel_h_pipe1/ (mu_fuel_pipe2(jj));
        Pr_fuel_pipe2(jj) = Cp_fuel_pipe2(jj) * mu_fuel_pipe2(jj) / k_fuel_pipe2(jj);

        % 연료
        if Re_fuel_pipe2(jj) >= 2300
            f_fuel_pipe2(jj) = 0.316*Re_fuel_pipe2(jj)^(-0.25);
            Nu_fuel_pipe2(jj) = ((f_fuel_pipe2(jj) / 8) * (Re_fuel_pipe2(jj) - 1000) * Pr_fuel_pipe2(jj)) / (1 + 12.7 * sqrt(f_fuel_pipe2(jj) / 8) * (Pr_fuel_pipe2(jj)^(2/3) - 1));

        else
            % 층류 입구효과 고려
            f_fuel_pipe2(jj) = 64/Re_fuel_pipe2(jj);
            Nu_fuel_pipe2(jj) = 3.66 ;

        end

        k_fuel_pipe2(jj) = fn_kf_find(T_fuel_pipe2(jj), p_fuel_pipe2(jj), akf, p);
        h_f_pipe2(jj) = Nu_fuel_pipe2(jj) * k_fuel_pipe2(jj) / D_fuel_h_pipe1; % 열전달계수 W/m2 K
        U_pipe2(jj) = 1 / ((1 / h_gas_pipe2(jj)) + (t_wall_pipe2 / k_wall_pipe2(jj)) + (1 / h_f_pipe2(jj))); % htotal
        q_total_pipe2(jj) = U_pipe2(jj)*A_heat_fuel_dx_pipe1*(T_gas_pipe2(jj)-T_fuel_pipe2(jj)); % 단위 총 열전달량
        T_wc_pipe2(jj) = T_fuel_pipe2(jj) + q_total_pipe2(jj)/(A_heat_fuel_dx_pipe1*h_f_pipe2(jj));
        T_wh_pipe2(jj) = T_wc_pipe2(jj) + q_total_pipe2(jj)*t_wall_pipe1/k_wall_pipe2(jj)/(A_heat_fuel_dx_pipe1);

    else
        rho_gas_pipe2(jj) = p_atm*M/R/T_gas_pipe2(jj);
        mu_gas_pipe2(jj) = 1.716e-5*((T_gas_pipe2(jj)/T0)^(3/2))*(T0+S_gas)/(T_gas_pipe2(jj)+S_gas);
        u_gas_pipe1(jj) = m_dot_gas / (rho_gas_pipe1(jj) * A_Re_gas_pipe1);
        Re_gas_pipe1(jj) = 2300;
        Cp_fuel_pipe2(jj) = fn_Cp_find(T_fuel_pipe2(jj), p_fuel_pipe2(jj), cp, p);
        k_wall_pipe2(jj) = (0.0158*T_wh_pipe2(jj-1) + 9.1661);
        mu_fuel_pipe2(jj) = fn_mu_find(T_fuel_pipe2(jj), p_fuel_pipe2(jj), mu, p)*1e-6;
        u_fuel_pipe2(jj) = m_dot_fuel / (rho_fuel_pipe2(jj) * A_Re_fuel_pipe1);
        Re_fuel_pipe2(jj) = rho_fuel_pipe2(jj) * u_fuel_pipe2(jj) * D_fuel_h_pipe1/ (mu_fuel_pipe2(jj));
        Pr_fuel_pipe2(jj) = Cp_fuel_pipe2(jj) * mu_fuel_pipe2(jj) / k_fuel_pipe2(jj);

        % 연료
        if Re_fuel_pipe2(jj) >= 2300
            f_fuel_pipe2(jj) = (1.82 * log10(Re_fuel_pipe2 (jj)) - 1.64)^-2;
            Nu_fuel_pipe2(jj) = ((f_fuel_pipe2(jj) / 8) * (Re_fuel_pipe2(jj) - 1000) * Pr_fuel_pipe2(jj)) / (1 + 12.7 * sqrt(f_fuel_pipe2(jj) / 8) * (Pr_fuel_pipe2(jj)^(2/3) - 1));

        else
            % 층류 입구효과 고려
            f_fuel_pipe2(jj) = 64/Re_fuel_pipe2(jj);

            if x_Hx2(jj) <= 0.05*Re_fuel_pipe2(jj)*Pr_fuel_pipe2(jj)*D_fuel_h_pipe1
                Nu_fuel_pipe2(jj) = 3.66 + 0.668*D_fuel_h_pipe1/(x_Hx2(jj)+0.5*dx)*Re_fuel_pipe2(jj)*Pr_fuel_pipe2(jj)/((1+0.04*D_fuel_h_pipe1/(x_Hx2(jj)+0.5*dx)*Re_fuel_pipe2(jj)*Pr_fuel_pipe2(jj))^(2/3)); % yiy
            else
                Nu_fuel_pipe2(jj) = 3.66 ;
            end

        end

        h_f_pipe2(jj) = Nu_fuel_pipe2(jj) * k_fuel_pipe2(jj) / D_fuel_h_pipe1; % 열전달계수 W/m2 K
        U_pipe2(jj) = 1 / ((1 / h_gas_pipe2(jj)) + (t_wall_pipe2 / k_wall_pipe2(jj)) + (1 / h_f_pipe2(jj))); % htotal
        q_total_pipe2(jj) = U_pipe2(jj)*A_heat_fuel_dx_pipe1*(T_fuel_pipe2(jj)-T_gas_pipe2(jj)); % 단위 총 열전달량
        T_wc_pipe2(jj) = T_fuel_pipe2(jj) + q_total_pipe2(jj)/(A_heat_fuel_dx_pipe1*h_f_pipe2(jj));
        T_wh_pipe2(jj) = T_wc_pipe2(jj) + q_total_pipe2(jj)*t_wall_pipe1/k_wall_pipe2(jj)/(A_heat_fuel_dx_pipe1);

    end

    T_fuel_pipe2(jj+1) = T_fuel_pipe2(jj) - q_total_pipe2(jj) / (Cp_fuel_pipe2(jj) * m_dot_fuel);
end
toc;


% plot_results_wallboundary
%%%%% 결과 플롯

%%% Initialization
set(groot, 'DefaultAxesFontSize', 12, 'DefaultAxesFontWeight', 'bold');
set(groot, 'DefaultTextFontSize', 12, 'DefaultTextFontWeight', 'bold');
set(groot, 'DefaultTextFontSize', 16, 'DefaultAxesTitleFontWeight', 'bold');

%%% Hx1 그래프
figure;
plot(x_Hx1(5:i-5)*1000, T_wh_Hx1(5:i-5)-T0, '-', 'LineWidth', 1.5);
hold on;
plot(x_Hx1(5:i-5)*1000, T_wc_Hx1(5:i-5)-T0, '-', 'LineWidth', 1.5);
hold on;
plot(x_Hx1(5:i-5)*1000, T_fuel_Hx1(5:i-5)-T0, '-', 'LineWidth', 2);
title('Hx1 열교환기 온도변화');
xlabel('Length [mm]');
ylabel('Temperature [deg C]');
legend({'가스 벽면 온도', '케로신 벽면 온도', '케로신 온도'}, 'Location', 'NorthEast');
grid on;

figure;
plot(x_Hx2(40:j-1)*1000, T_wh_Hx2(40:j-1)-T0, '-', 'LineWidth', 1.5);
hold on;
plot(x_Hx2(40:j-1)*1000, T_wc_Hx2(40:j-1)-T0, '-', 'LineWidth', 1.5);
hold on;
plot(x_Hx2(40:j-1)*1000, T_fuel_Hx2(40:j-1)-T0, '-', 'LineWidth', 2);
title('Hx2 열교환기 온도변화');
xlabel('Length [mm]');
ylabel('Temperature [deg C]');
legend({'가스 벽면 온도', '케로신 벽면 온도', '케로신 온도'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(5:i-1)*1000, T_fuel_Hx1(5:i-1)-T0, '-', 'LineWidth', 2);
hold on
plot(x_Hx2(5:j-1)*1000, T_fuel_Hx2(5:j-1)-T0, '-', 'LineWidth', 2);
title('Fuel Temperature');
xlabel('Length [mm]');
ylabel('Fuel Temperature [deg C]');
legend({'Hx1(Up side, co-flow)', 'Hx2(Down side, count-flow)'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(5:i-1)*1000, h_fuel_Hx1(5:i-1), '-', 'LineWidth', 2);
hold on;
plot(x_Hx2(5:j-1)*1000, h_fuel_Hx2(5:j-1), '-', 'LineWidth', 2);
title('Convective heat transfer coefficients of Fuel');
xlabel('Length [mm]');
ylabel('h  [W/m^2K]');
legend({'Hx1', 'Hx2'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, Nu_fuel_Hx1(10:i-1), '-', 'LineWidth', 2 )
title('Fuel Nusselt Number Hx1');
xlabel('Length [mm]');
ylabel('Fuel Nusselt Number');
legend({'Nusselt Number'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, mu_fuel_Hx1(10:i-1), '-', 'LineWidth', 2)
title('Fuel dynamic viscosity Hx1');
xlabel('Length [mm]');
ylabel('Fuel dynamic viscosity [Pa s]');
legend({'mu'}, 'Location', 'NorthEast');
grid on

figure
plot(x_Hx1(10:i-1)*1000, Re_fuel_Hx1(10:i-1), '-', 'LineWidth', 2);
title('Fuel Reynolds number Hx1');
xlabel('Length [mm]');
ylabel('Reynolds number');
legend({'Fuel Re'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, Cp_fuel_Hx1(10:i-1), '-', 'LineWidth', 2);
title('Heat capacity at constant pressure Hx1');
xlabel('Length [mm]');
ylabel('Heat capacity at constant pressure[J/(kg*K)]');
legend({'C_p fuel'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, k_fuel_Hx1(10:i-1), '-', 'LineWidth', 2);
title('Fuel thermal conductivity Hx1');
xlabel('Length [mm]');
ylabel('Fuel thermal conductivity [W/(m*K)]');
legend({'k fuel'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, k_wall_Hx1(10:i-1), '-', 'LineWidth', 2);
title('Fuel thermal conductivity Hx1');
xlabel('Length [mm]');
ylabel('Wall thermal conductivity [W/(m*K)]');
legend({'k_w_a_l_l'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, rho_fuel_Hx1(10:i-1), '-', 'LineWidth', 2);
title('rho fuel Hx1');
xlabel('Length [mm]');
ylabel('Density of fuel [kg/m^3]');
legend({'Density of fuel'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, u_fuel_Hx1(10:i-1), '-', 'LineWidth', 2);
title('fuel velocity Hx1');
xlabel('Length [mm]');
ylabel('fuel velocity [m/s]');
legend({'fuel velocity'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, q_total_Hx1(10:i-1)/A_heat_fuel_dx_Hx1, '-', 'LineWidth', 2);
hold on
xlabel('Length [mm]');
ylabel('Q [W/m^2]');
title('Heat transfer at the point Hx1');
legend({'q total'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx1(10:i-1)*1000, p_fuel_Hx1(10:i-1), '-', 'LineWidth', 2);
hold on
xlabel('Length [mm]');
ylabel('Pressure [kPa]');
title('Fuel Pressure Hx1')
grid on;


%%% Hx2 그래프
figure
plot(x_Hx2(10:j-1)*1000, Nu_fuel_Hx2(10:j-1), '-', 'LineWidth', 2 )
title('Fuel Nusselt Number Hx2');
xlabel('Length [mm]');
ylabel('Fuel Nusselt Number');
legend({'Nusselt Number'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, mu_fuel_Hx2(10:j-1), '-', 'LineWidth', 2)
title('Fuel dynamic viscosity Hx2');
xlabel('Length [mm]');
ylabel('Fuel dynamic viscosity [Pa s]');
legend({'mu'}, 'Location', 'NorthEast');
grid on

figure
plot(x_Hx2(10:j-1)*1000, Re_fuel_Hx2(10:j-1), '-', 'LineWidth', 2);
title('Fuel Reynolds number Hx2');
xlabel('Length [mm]');
ylabel('Reynolds number');
legend({'Fuel Re'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, Cp_fuel_Hx2(10:j-1), '-', 'LineWidth', 2);
title('Heat capacity at constant pressure Hx2');
xlabel('Length [mm]');
ylabel('Heat capacity at constant pressure[J/(kg*K)]');
legend({'C_p fuel'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, k_fuel_Hx2(10:j-1), '-', 'LineWidth', 2);
title('Fuel thermal conductivity Hx2');
xlabel('Length [mm]');
ylabel('Fuel thermal conductivity [W/(m*K)]');
legend({'k fuel'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, k_wall_Hx2(10:j-1), '-', 'LineWidth', 2);
title('Fuel thermal conductivity Hx2');
xlabel('Length [mm]');
ylabel('Wall thermal conductivity [W/(m*K)]');
legend({'k wall'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, rho_fuel_Hx2(10:j-1), '-', 'LineWidth', 2);
title('rho fuel Hx2');
xlabel('Length [mm]');
ylabel('Density of fuel [kg/m^3]');
legend({'Density of fuel'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, u_fuel_Hx2(10:j-1), '-', 'LineWidth', 2);
title('fuel velocity Hx2');
xlabel('Length [mm]');
ylabel('fuel velocity [m/s]');
legend({'fuel velocity'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, q_total_Hx2(10:j-1), '-', 'LineWidth', 2);
hold on
xlabel('Length [mm]');
ylabel('Q [W]');
title('Heat transfer at the point Hx2');
legend({'q total'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, Q_total_Hx2(10:j-1)/A_heat_fuel_dx_Hx1, '-', 'LineWidth', 2);
hold on
xlabel('Length [mm]');
ylabel('Q [W/m^2]');
title('Total Heat transfer Hx2')
legend({'Q total'}, 'Location', 'NorthEast');
grid on;

figure
plot(x_Hx2(10:j-1)*1000, p_fuel_Hx2(10:j-1), '-', 'LineWidth', 2);
hold on
xlabel('Length [mm]');
ylabel('Pressure [kPa]');
title('Fuel Pressure Hx2')
grid on;

%%% 수치 작성
fprintf('Hx1 종단 연료온도 = %4.2f oC \n', T_fuel_Hx1(i-1) - T0);
fprintf('Hx1 종단 연료벽면온도 = %4.2f oC \n', T_wc_Hx1(i-1)- T0);
fprintf('Hx1 종단 가스벽면온도 = %4.2f oC \n', T_wh_Hx1(i-1)- T0);
fprintf('Hx1 연료온도 변화 = %4.2f oC \n', T_fuel_Hx1(i-1)-T_fuel_Hx1(1));
fprintf('Hx1 Q_total= %4.2f [kW] \n', Q_total_Hx1(i-1)/1000);
fprintf('Hx1 heat flux= %4.2f [kW/m^2] \n', Q_total_Hx1(i-1)/1000/A_heat_fuel_Hx1);
fprintf('Hx1 종단 연료압력 = %4.2f [MPa] \n', p_fuel_Hx1(i)/1000);

fprintf('\n\n');
fprintf('Hx2 연료 입구온도 = %4.2f oC \n', T_fuel_pipe1(ii-1)-T0);
fprintf('Hx2 종단 연료온도 = %4.2f oC \n', T_fuel_Hx2(j-1)- T0);
fprintf('Hx2 종단 연료벽면온도 = %4.2f oC \n', T_wc_Hx2(j-1)- T0);
fprintf('Hx2 종단 가스벽면온도 = %4.2f oC \n', T_wh_Hx2(j-1)- T0);
fprintf('Hx2 연료온도 변화 = %4.2f oC \n', T_fuel_Hx2(j-1)-T_fuel_Hx2(1));
fprintf('Hx2 Q_total= %4.2f [kW] \n', Q_total_Hx2(j-1)/1000);
fprintf('Hx2 heat flux= %4.2f [kW/m^2] \n', Q_total_Hx2(j-1)/1000/A_heat_fuel_Hx2);
fprintf('Hx2 종단 연료압력 = %4.2f [MPa] \n', p_fuel_Hx2(j)/1000);
fprintf('pipe1 온도변화 = %4.2f [oC] \n', T_fuel_pipe1(1)-T_fuel_pipe1(ii));
fprintf('pipe2 온도변화 = %4.2f [oC] \n', T_fuel_pipe2(1)-T_fuel_pipe2(jj));
fprintf('인젝터 입구온도 = %4.2f oC \n\n', T_fuel_pipe2(jj-1)-T0);
fprintf('total heat flux= %4.2f [kW/m^2] \n', (Q_total_Hx1(i-1)+Q_total_Hx2(j-1))/1000/(A_heat_fuel_Hx1+A_heat_fuel_Hx2));

