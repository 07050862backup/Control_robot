clc;clear;close all;
R = 500;
L = 5e-3;
C = 1e-8;

t_s=0;dt=1e-6;t_d=2e-3;
Ec =  zeros(1,2000);%電容電壓
I  = zeros(1,2000);%電感電流
E  = zeros(1,2000);%電源電壓
E(1)=5; % 初始電壓為5V
k=0;
for i = t_s:dt:t_d
  k = k+1;
  t(k)=i;
  %輸入電壓(方波)
  %方波頻率為1KHz，表示週期為T=1e-3(sec)
  %即每T=0.5e-3(sec)，訊號需轉態H->L or L->H
  %若考慮取樣時間設定為1e-6
  %則k變數每計數500，E變數需轉態
  if mod(k,500)==0
    E(k+1)=-E(k);
  else
    E(k+1)=E(k);
  end
  %I(k) = (E(k)-Ec(k))/R;
  Ec(k+1) = (1/C)*I(k)*dt+Ec(k);
  I(k+1)=((-1/L)*Ec(k)+(-R/L)*I(k)+(1/L)*E(k))*dt+I(k);
end

index = length(t);
figure;box on;
subplot(3,1,1);plot(t(1:index),Ec(1:index))
xlabel('time(sec)')
ylabel('Ec(t)')
#axis([0 t_d min(Ec) 1.1 max(Ec) 1.1])
subplot(3,1,2);plot(t(1:index),I(1:index))
xlabel('time(sec)')
ylabel('I(t)')
#axis([0 t_d min(I) 1.1 max(I) 1.1])
subplot(3,1,3);plot(t(1:index),E(1:index))
xlabel('time(sec)')
ylabel('E(t)')
#axis([0 t_d min(E) 1.1 max(E) 1.1])