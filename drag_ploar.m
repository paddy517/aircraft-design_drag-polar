%% induce drag coefficient
V = linspace(80,500);
W = 260000*9.8*0.78;
AR = 7.225;
e = 0.832; % e = 1.78(1-0.445*AR^(0.68))-0.64


q = 0.5*(0.3428)*(V).^2;
S = 370;
Cl = W./(q*S);
Cdi = (Cl).^2/(e*pi*AR);
drag_induced = 0.5*(0.3428)*(V).^(2).*Cdi*S;
plot(V,drag_induced,'g');
hold on
%% parasite drag
Re = 40000000;
Mach = V/343; %u/c
Cd_other = 0.001;
t_c = 0.12; %(thickness/average chord) 
S_wet = S*(1.977+0.52*(t_c));

a = (log10(Re))^2.58;
b = (1+0.1144.*(Mach.^2)).^0.65;

Cf = 0.455./(a*b);
Cd0 = Cf*(S_wet/S)+Cd_other;
drag_zero = 0.5*(0.3428)*(V).^(2).*Cd0*S;

plot(V,drag_zero,"b");
hold on
%% drag
Cd = Cd0 + Cdi;
% plot(Cd,Cl);
drag = drag_zero + drag_induced;
plot(V,drag,"r");
legend('induced drag','parasite drag','total drag');
xlabel('Velocity (m/s)');
ylabel('Drag force (N)');

