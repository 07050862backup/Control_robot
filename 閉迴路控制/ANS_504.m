clc;clear;close all;
R=500;
L=5e-3;
C=1e-8;
Jm=7.5e-5;
Bm=2e-5;
Ki = 0.0323;
Ke = 0.0323;
Kb = 0.0323;
Ra=0.19;
La=5e-4;
Wm=0;
theta=0;
TL=0;
Ia=0;
t_s=0;dt=1e-3;t_d=1;
Ec = zeros(1,2000);%電容電壓
I = zeros(1,2000);%電感電流
Ea = zeros(1,2000);%電源電壓
Ea(1)=12; %初始電壓為12V
Kp = 0.8;
Wref = 0;
Tref = 0;
k=0;

for i = t_s:dt:t_d
    k = k+1;
    t(k) = i;
    TL(k)=0;
    if t<0.2
        Tref(k) = 90*pi/180;    %換成rad
    elseif t<0.4
        Tref(k) = 180*pi/180;
    elseif t<0.6
        Tref(k) = 0*pi/180;
    elseif t<0.8
        Tref(k) = -45*pi/180;
    else
        Tref(k) = -135*pi/180;
    end
    err(k) = Tref(k)-theta(k);
    Ea(k) = Kp*err(k);
    
    Eb(k+1) = Kb*Wm(k);
    Ia(k+1)=(Ea(k)-Ra*Ia(k)-Eb(k))/La*dt+Ia(k);
    Tm(k+1)=Ki*Ia(k);
    Wm(k+1)=(Tm(k)-TL(k)-Bm*Wm(k))/Jm*dt+Wm(k);
    theta(k+1)=Wm(k)*dt+theta(k); 
end

index = length(t);
figure;hold on;
subplot(3,1,1);
plot(t(1:index),Tref(1:index)*180/pi,'r',t(1:index),theta(1:index)*180/pi,'b')
xlabel('time(sec)');ylabel('Tref(t)');
legend('\thetaref','\theta');
title('\bf \thetaref&\theta    -    t');
grid on
subplot(3,1,2);plot(t(1:index),Ea(1:index))
xlabel('time(sec)');ylabel('Ea(t)');
title('\bf Ea - t');
grid on
subplot(3,1,3);plot(t(1:index),theta(1:index)*180/pi);
xlabel('time(sec)');ylabel('\theta(°)');
title('\bf \theta  -  t');
grid on