clear;clc;close all;

global r=0.03; %(���l�b�|3����)
global L=0.1; %���b���Z10cm

time_start = 0; %�����_�l�ɶ�
time_end = 36; %�����ɶ�6sec
time_sampling = 0.001 %�����ɶ����j 0.001sec

%�ܼƪŶ���l��(�D���n)
iterNumber = time_end/time_sampling;
positionX = zeros(1,iterNumber);
positionY = zeros(1,iterNumber);
velocityX = zeros(1,iterNumber);
velocityY = zeros(1,iterNumber);
omega = zeros(1,iterNumber);
theta = zeros(1,iterNumber);
rightWheel = zeros(1, iterNumber);
leftWheel = zeros(1,iterNumber);

%�ܼƪ�l��
positionX(1) = 2;
positionY(1) = 2;
theta(1) = pi/2;

%�����D�{��
iter = 0;
for time=time_start:time_sampling:time_end
  iter += 1;
  if time <= 2
    Wheel = fun_robotRotation(2, pi*(45/180), 0);
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  elseif time <= 11
    Wheel = fun_robotRotation(9, -pi, 1.5/(2^0.5));
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  elseif time <= 12
    Wheel = fun_robotRotation(1, pi*(90/180), 0);
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  elseif time <= 21
    Wheel = fun_robotRotation(9, -pi, 1.5/(2^0.5));
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  elseif time <= 28
    Wheel = fun_robotStraight(7,3/(2^0.5));
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  elseif time <= 29
    Wheel = fun_robotRotation(1, pi*(-90/180), 0);
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  elseif time <= 36
    Wheel = fun_robotStraight(7,3/(2^0.5));
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  else 
    Wheel = [0 0];
    rightWheel(iter) = Wheel(1);
    leftWheel(iter) = Wheel(2);
  endif
  
  
  matrixRotation = [cos(theta(iter)) -sin(theta(iter)) 0; 
                    sin(theta(iter)) cos(theta(iter)) 0;
                    0 0 1];
  matrixWheel = [r/2 r/2; 0 0; r/L -r/L];
  
  velocity = matrixRotation * matrixWheel * [rightWheel(iter);leftWheel(iter)];
  velocityX(iter) = velocity(1);
  velocityY(iter) = velocity(2);
  omega(iter) = velocity(3);
  
  %wheeled robot model
  if time != time_end
    positionX(iter+1) = positionX(iter) + velocityX(iter)*time_sampling;
    positionY(iter+1) = positionY(iter) + velocityY(iter)*time_sampling;
    theta(iter+1) = theta(iter) + omega(iter)*time_sampling;
  endif
endfor

%ø��
time = (time_start:time_sampling:time_end);
figure(1); hold on;
plot(positionX,positionY,'r');
plot(positionX(1),positionY(1),'o');
xlabel('PositionX(m)');
ylabel('PositionY(m)');
figure(2);hold on;
subplot(6,1,1:2);plot(time,rightWheel,time,leftWheel);title('Plot of rightWheel&leftWheel vs time');xlabel('time(sec)');ylabel('Wheel');legend('rW','lW','tl');
subplot(6,1,3:4);plot(time,theta*180/pi,'b');title('Plot of angle vs time');xlabel('time(sec)');ylabel('angle\theta(rad)');
subplot(6,1,5:6);plot(positionX,positionY,'r');;title('Plot of x-y coordinates');xlabel('PositionX(m)');ylabel('PositionY(m)');
