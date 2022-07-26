clc;clear;close all;
R = 500;
L = 5e-3;
C = 1e-8;

t_s=0;dt=1e-6;t_d=2e-3;
Ec =  zeros(1,2000);%�q�e�q��
I  = zeros(1,2000);%�q�P�q�y
E  = zeros(1,2000);%�q���q��
E(1)=5; % ��l�q����5V
k=0;
for i = t_s:dt:t_d
  k = k+1;
  t(k)=i;
  %��J�q��(��i)
  %��i�W�v��1KHz�A��ܶg����T=1e-3(sec)
  %�Y�CT=0.5e-3(sec)�A�T������AH->L or L->H
  %�Y�Ҽ{���ˮɶ��]�w��1e-6
  %�hk�ܼƨC�p��500�AE�ܼƻ���A
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