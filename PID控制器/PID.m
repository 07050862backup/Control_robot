clc;clear;close all;
R=500;
L=5e-4;
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
t_s=0;dt=1e-4;t_d=1;
Ec = zeros(1,2000);%電容電壓
I = zeros(1,2000);%電感電流
Ea = zeros(1,2000);%電源電壓
Ea(1)=12; %初始電壓為12V
err = 0;
Ci = 0;
Kp = 0.01;
KI = 0.9;
Wref = 0;
k=0;
D=0;
KD = 0.001;
for i = t_s:dt:t_d
    k = k+1;
    t(k) = i;
    TL(k)=0;
    if t<0.5
        Wref(k) = 1000/30*pi;
    else
        Wref(k) = -500/30*pi;
    end
    err(k) = Wref(k)-Wm(k);%誤差=命令-回授值 
    if k > 1
       D(k)=KD*(err(k)-err(k-1))/dt;
    end
    Ci(k+1)= KI*err(k)*dt+Ci(k); %只要有誤差存在，會不斷累積誤差的量，到一定程度會使電壓也變大，然後把誤差給壓下來
    Ea(k) = Kp*err(k)+Ci(k+1)+D(k);
    
    
    
    Eb(k+1) = Kb*Wm(k);
    Ia(k+1)=(Ea(k)-Ra*Ia(k)-Eb(k))/La*dt+Ia(k);
    Tm(k+1)=Ki*Ia(k);
    Wm(k+1)=(Tm(k)-TL(k)-Bm*Wm(k))/Jm*dt+Wm(k);
    theta(k+1)=Wm(k)*dt+theta(k);
   
end

index = length(t);
figure;hold on;
subplot(4,1,1:2)
plot(t(1:index),Wref(1:index)*(60/(2*pi)),'r',t(1:index),Wm(1:index)*(60/(2*pi)),'b');
ylabel('Wref&Wm(t)');
legend('Wref','Wm');
title('\bf Wref&Wm - t');
grid on
subplot(4,1,3);plot(t(1:index),Ea(1:index))
ylabel('Ea(t)');
title('\bf Ea - t');
grid on
subplot(4,1,4);plot(t(1:index),theta(1:index));
xlabel('time(sec)');ylabel('\theta(°)');
title('\bf \theta - t');
grid on
