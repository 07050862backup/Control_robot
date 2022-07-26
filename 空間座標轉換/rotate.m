clear;clc;close all;

syms A B Y
SIN=sin(Y);
COS=cos(Y);
RxA = [COS COS COS
       COS cos(A) -sin(A)
       COS sin(A) cos(A)];

RxA(1,1)=1;
RxA(1,3)=0;
RxA(1,2)=0;
RxA(2,1)=0;
RxA(3,1)=0;
RxB = [COS COS COS
       COS cos(B) -sin(B)
       COS sin(B) cos(B)];
RxB(1,1)=1;
RxB(1,3)=0;
RxB(1,2)=0;
RxB(2,1)=0;
RxB(3,1)=0;
RxY = [COS COS COS
       COS cos(Y) -sin(Y)
       COS sin(Y) cos(Y)];
RxY(1,1)=1;
RxY(1,3)=0;
RxY(1,2)=0;
RxY(2,1)=0;
RxY(3,1)=0;
RyA = [cos(A) COS sin(A)
       COS COS -SIN
       -sin(A) COS cos(A)];
RyA(2,2)=1;
RyA(1,2)=0;
RyA(2,1)=0;
RyA(2,3)=0;
RyA(3,2)=0;
RyB = [cos(B) COS sin(B)
       COS COS -SIN
       -sin(B) COS cos(B)];
RyB(2,2)=1;
RyB(1,2)=0;
RyB(2,1)=0;
RyB(2,3)=0;
RyB(3,2)=0;
RyY = [cos(Y) COS sin(Y)
       COS COS -SIN
       -sin(Y) COS cos(Y)];
RyY(2,2)=1;
RyY(1,2)=0;
RyY(2,1)=0;
RyY(2,3)=0;
RyY(3,2)=0;

RzA = [cos(A) -sin(A) COS
       sin(A) cos(A) -SIN
       COS SIN COS];
RzA(3,3)=1;
RzA(1,3)=0;
RzA(2,3)=0;
RzA(3,1)=0;
RzA(3,2)=0;
RzB = [cos(B) -sin(B) COS
        sin(B) cos(B) -SIN
        COS SIN COS];
RzB(3,3)=1;
RzB(1,3)=0;
RzB(2,3)=0;
RzB(3,1)=0;
RzB(3,2)=0;

RzY = [cos(Y) -sin(Y) COS
        sin(Y) cos(Y) -SIN
        COS SIN COS];
RzY(3,3)=1;
RzY(1,3)=0;
RzY(2,3)=0;
RzY(3,1)=0;
RzY(3,2)=0;

%Fixed angles之轉換矩陣
Fixed_angle_Rxyz=RzA*RyB*RxY
Fixed_angle_Rxyx=RxA*RyB*RxY
Fixed_angle_Rxzx=RxA*RzB*RxY
Fixed_angle_Rxzy=RyA*RzB*RxY
Fixed_angle_Ryxz=RzA*RxB*RyY
Fixed_angle_Ryxy=RyA*RxB*RyY
Fixed_angle_Ryzx=RxA*RzB*RyY
Fixed_angle_Ryzy=RyA*RzB*RyY
Fixed_angle_Rzxy=RyA*RxB*RzY
Fixed_angle_Rzxz=RzA*RxB*RzY
Fixed_angle_Rzyx=RxA*RyB*RzY
Fixed_angle_Rzyz=RzA*RyB*RzY

%Euler Angle之轉換矩陣
Euler_Angle_Rxyz=RxA*RyB*RzY
Euler_Angle_Rxyx=RxA*RyB*RxY
Euler_Angle_Rxzx=RxA*RzB*RxY
Euler_Angle_Rxzy=RxA*RzB*RyY
Euler_Angle_Ryxz=RyA*RxB*RzY
Euler_Angle_Ryxy=RyA*RxB*RyY
Euler_Angle_Ryzx=RyA*RzB*RxY
Euler_Angle_Ryzy=RyA*RzB*RyY
Euler_Angle_Rzxy=RzA*RxB*RyY
Euler_Angle_Rzxz=RzA*RxB*RzY
Euler_Angle_Rzyx=RzA*RyB*RxY
Euler_Angle_Rzyz=RzA*RyB*RzY

