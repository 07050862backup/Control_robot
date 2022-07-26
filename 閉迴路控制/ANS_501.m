clc;clear;close all;
Jm = 7.5e-5;
Bm = 2e-5;
Ki = 0.0323;
Ke = 0.0323;
Kb = 0.0323;
Ra = 0.19;
La = 5e-4;

t_s=0;dt=1e-3;t_d=1;
ea = zeros(1,2000);
eb = zeros(1,2000);
Wm = zeros(1,2000);
ia = zeros(1,2000);
theta = zeros(1,2000);
k=0;
ea(1)=12;
for t=t_s:dt:t_d
  k=k+1;
  T(k)=t; 
  %輸入電壓(方波)
  %方波頻率為4Hz，表示週期為T=0.25(sec) 
  %即每T=0.125(sec)，訊號需轉態H->L or L->H 
  %若考慮取樣時間設定為0.001 
  %則k變數每計數125，E變數需轉態
  if mod(k,125)==0
    ea(k+1)=-ea(k);
  else
    ea(k+1)=ea(k);
  end
  TL(k)=0;
  Tm(k+1)=Ki*ia(k);
  Wm(k+1)=(Tm(k)-TL(k)-Bm*Wm(k))/Jm*dt+Wm(k);
  eb(k+1)=Kb*Wm(k);
  ia(k+1)=(ea(k)-Ra*ia(k)-eb(k))/La*dt+ia(k);
  theta(k+1)=Wm(k)*dt+theta(k);
end
index = length(T);
figure;box on;
subplot(4,1,1);plot(T(1:index),ea(1:index))
xlabel('time(sec)')
ylabel('Ea(t)(V)')
title('\bf Ea - t');
axis([0 1 -15 15])%axis([xmin xmax ymin ymax])
grid on
subplot(4,1,2);plot(T(1:index),ia(1:index))
xlabel('time(sec)')
ylabel('Ia(t)(A)')
title('\bf I - t');
grid on
%axis([0 t_d min(Ec) 1.1 max(Ec) 1.1])
subplot(4,1,3);plot(T(1:index),Wm(1:index)*(60/(2*pi)))
xlabel('time(sec)')
ylabel('\omega(t)(RPM)')
title('\bf \omega - t');
grid on
subplot(4,1,4);plot(T(1:index),theta(1:index)*(pi/180))
xlabel('time(sec)')
ylabel('\theta(rad)')
title('\bf \theta - t');
grid on