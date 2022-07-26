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
t_s=0;dt=1e-4;t_d=4;
Ec = zeros(1,2000);%電容電壓
I = zeros(1,2000);%電感電流
Ea = zeros(1,2000);%電源電壓
Ea(1)=12; %初始電壓為12V
err = 0;

Kp = 0.1;
KI = 0.09;
KD = 0.001;

Wref = 0;
k=0;


K = 0;
Ci = 0;
D=0;

for i = t_s:dt:t_d
    k = k+1;
    t(k) = i;
    TL(k)=0;
    
    Wref(k) = 500*sin(pi*i)/30*pi;
   
    err(k) = Wref(k)-Wm(k);%誤差=命令-回授值 
    K(k) = Kp*err(k);
    if k > 1
       D(k)=KD*(err(k)-err(k-1))/dt;
    end
    Ci(k+1)= KI*err(k)*dt+Ci(k); %只要有誤差存在，會不斷累積誤差的量，到一定程度會使電壓也變大，然後把誤差給壓下來
    Ea(k) = K(k)+Ci(k+1)+D(k);
    
    
    
    Eb(k+1) = Kb*Wm(k);
    Ia(k+1)=(Ea(k)-Ra*Ia(k)-Eb(k))/La*dt+Ia(k);
    Tm(k+1)=Ki*Ia(k);
    Wm(k+1)=(Tm(k)-TL(k)-Bm*Wm(k))/Jm*dt+Wm(k);
    theta(k+1)=Wm(k)*dt+theta(k);
   
end

index = length(t);
figure;hold on;
subplot(3,1,1)
plot(t(1:index),Ea(1:index),'k',t(1:index),K(1:index),'r',t(1:index),Ci(1:index),'g',t(1:index),D(1:index),'b');
legend('Ea','P','I','D');
grid on
subplot(3,1,2)
plot(t(1:index),Wref(1:index)*(60/(2*pi)),'r',t(1:index),Wm(1:index)*(60/(2*pi)),'b');
ylabel('Wref&Wm(RPM)');
legend('Wref','Wm');
axis([0 t_d min(Wref)*(60/(2*pi))*1.1 max(Wref)*(60/(2*pi))*1.1]);
title('\bf Wref&Wm - t');
grid on
subplot(3,1,3);plot(t(1:index),err(1:index))
xlabel('time(sec) 07050755');
ylabel('error');
title('\bf Ea - t');
grid on