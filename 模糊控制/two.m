%雙輸入模糊控制，需再修改
clear,clc,close all;
Ra = 0.19;
La = 5e-4;
Kb = 0.0323;
Ki = 0.0323;
Jm = 7.5e-5;
Bm = 2e-5;
uMFOut = [0 0 0 0 0];
paraMF_in=[-1 -0.5 0 0.5 1];
paraMF_out=[-1 -0.5 0 0.5 1];
K_in=0.1;
K_out=10;

t_s=0;dt=1e-4;t_d=1;
Ia = zeros(1,t_d/dt+1);% i_a
Wm = zeros(1,t_d/dt+1);% \omega
theta = zeros(1,t_d/dt+1);% \theta
t = zeros(1,t_d/dt+1);
Ea = zeros(1,t_d/dt+1);
TL = zeros(1,t_d/dt+1);
theta_ref = zeros(1,t_d/dt+1);
err_temp=0;
k=0;

for i = t_s:dt:t_d
    k = k+1;
    t(k) = i;
    %theta_ref(k) = 1000*sin(2*pi*1*i)*pi/30;
    if i<t_d/2
        theta_ref(k) = 30/180*pi;
    else
        theta_ref(k) = -30/180*pi;
    end
   
%  P  Controller
%  error = theta_ref(k)-theta(k);
%  Ea(k) = error*1;

% Fuzzy Controller
  error = theta_ref(k)-theta(k);
  derr=(error-err_temp)/dt;
  err_temp=error;
  
  in1=error;
  in2=derr;
  
  
  in1=in1*K_in;
  %Fuzzification: find the degree of each MF
  valueMFin1 = [0 0 0 0 0];
  inputMF1 = error*K_in; %模糊的輸入值 = 誤差 * 量化因子
if inputMF1 < paraMF_in(1)
    valueMFin1(1)=1;
elseif inputMF1 < paraMF_in(2)
    valueMFin1(1) = (paraMF_in(2)-inputMF1)/(paraMF_in(2)-paraMF_in(1));
    valueMFin1(2) = 1 - valueMFin1(1);
elseif inputMF1 < paraMF_in(3)
    valueMFin1(2) = (paraMF_in(3)-inputMF1)/(paraMF_in(3)-paraMF_in(2));
    valueMFin1(3) = 1 - valueMFin1(2);
elseif inputMF1 < paraMF_in(4)
    valueMFin1(3) = (paraMF_in(4)-inputMF1)/(paraMF_in(4)-paraMF_in(3));
    valueMFin1(4) = 1 - valueMFin1(3);
elseif inputMF1 < paraMF_in(5)
    valueMFin1(4) = (paraMF_in(5)-inputMF1)/(paraMF_in(5)-paraMF_in(4));
    valueMFin1(5) = 1 - valueMFin1(4);
else
    valueMFin1(5) = 1;
end


valueMFOUT = [0 0 0 0 0];
OUTPUTMF1=in2*K_out;
if OUTPUTMF1 < paraMF_out(1)
    valueMFOUT(1)=1;
elseif OUTPUTMF1 < paraMF_out(2)
    valueMFOUT(1) = (paraMF_out(2)-OUTPUTMF1)/(paraMF_out(2)-paraMF_out(1));
    valueMFOUT(2) = 1 - valueMFOUT(1);
elseif OUTPUTMF1 < paraMF_in(3)
    valueMFOUT(2) = (paraMF_out(3)-OUTPUTMF1)/(paraMF_out(3)-paraMF_out(2));
    valueMFOUT(3) = 1 - valueMFOUT(2);
elseif OUTPUTMF1 < paraMF_in(4)
    valueMFOUT(3) = (paraMF_out(4)-OUTPUTMF1)/(paraMF_out(4)-paraMF_out(3));
    valueMFOUT(4) = 1 - valueMFOUT(3);
elseif OUTPUTMF1 < paraMF_in(5)
    valueMFOUT(4) = (paraMF_out(5)-OUTPUTMF1)/(paraMF_out(5)-paraMF_out(4));
    valueMFOUT(5) = 1 - valueMFOUT(4);
else
    valueMFOUT(5) = 1;
end




    %deFuzzification: calculate the output of FLC
    for i=1:5
        Ea(k) = valueMFin1(i)*paraMF_out(i)*K_out + Ea(k);
    end
  uMFOut(1)=max([min(valueMFin1(1),valueMFOUT(1)),min(valueMFin1(1),valueMFOUT(2)),min(valueMFin1(1),valueMFOUT(3)),min(valueMFin1(1),valueMFOUT(4)),min(valueMFin1(2),valueMFOUT(1)),min(valueMFin1(3),valueMFOUT(1)),min(valueMFin1(1),valueMFOUT(4))]);
  uMFOut(2)=max([min(valueMFin1(2),valueMFOUT(2)),min(valueMFin1(2),valueMFOUT(3)),min(valueMFin1(3),valueMFOUT(2)),min(valueMFin1(4),valueMFOUT(1))]);
  uMFOut(3)=max([min(valueMFin1(1),valueMFOUT(5)),min(valueMFin1(2),valueMFOUT(4)),min(valueMFin1(3),valueMFOUT(3)),min(valueMFin1(4),valueMFOUT(2)),min(valueMFin1(5),valueMFOUT(1))]);
  uMFOut(4)=max([min(valueMFin1(2),valueMFOUT(5)),min(valueMFin1(3),valueMFOUT(4)),min(valueMFin1(4),valueMFOUT(3)),min(valueMFin1(4),valueMFOUT(4)),min(valueMFin1(5),valueMFOUT(1))]);
  uMFOut(5)=max([min(valueMFin1(3),valueMFOUT(5)),min(valueMFin1(4),valueMFOUT(5)),min(valueMFin1(4),valueMFOUT(3)),min(valueMFin1(5),valueMFOUT(2)),min(valueMFin1(5),valueMFOUT(3)),min(valueMFin1(5),valueMFOUT(4)),min(valueMFin1(5),valueMFOUT(5))]);
  AA = sum(uMFOut);
  Out=  (paraMF_out.*uMFOut)/((AA));
   

    %  TL(k) = 0;  Ia = Ia ; Wm = Wm; theta = theta
    
    Ia(k+1) = (-Ra/La*Ia(k)-Kb/La*Wm(k) + 1/La*Ea(k))*dt + Ia(k);
    Wm(k+1) = (Ki/Jm*Ia(k) - Bm/Jm*Wm(k) - 1/Jm*TL(k) )*dt + Wm(k);
    theta(k+1) = (Wm(k))*dt + theta(k);
    
end
   
index = length(t);
figure;box on;

subplot(3,1,1);plot(t(1:index),Ea(1:index));xlabel('time(sec)');ylabel('E_a(t)  (V)');
axis([0 t_d min(Ea)*1.1 max(Ea)*1.1]);
grid on
subplot(3,1,2);plot(t(1:index),theta(1:index)*180/pi,'b',t(1:index),theta_ref(1:index)*180/pi,'r:')
xlabel('time(sec)');
ylabel('\theta(t)(°)&\thetaref');
axis([0 t_d min(theta)*180/pi*1.1 max(theta)*180/pi*1.1]);
grid on
subplot(3,1,3);plot(t(1:index),Wm(1:index)*180/pi);xlabel('time(sec)');ylabel('\omega(t)(RPM)');
axis([0 t_d min(Wm)*180/pi*1.1 max(Wm)*180/pi*1.1])
grid on
    