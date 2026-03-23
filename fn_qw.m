function [qw] = fn_qw(x_query, KJS)

% KJS = load("KJS.dat");

Twh_x = KJS(:,1); %[m]
qw_kjs = KJS(:,11); % initial

if x_query < min(Twh_x)
    qw = qw_kjs(1);

elseif x_query > max(Twh_x)
    qw = qw_kjs(end);

else
    qw = interp1(Twh_x, qw_kjs, x_query, 'linear', 'extrap') ;

end

end
