function plotcmplx(z,c)

% Usage:
% plotarrow(z,c);
% 
% 	- z is a complex number
% 	- c = 'b' for blue color, 'r' for red color, etc
%
% Adapted from "phasor.m" script from Copyright (c) 2009, Erik Cheever
% Copyright (c) 2010, Andres Kwasinski

newplot 

A=abs(z);
phi=angle(z);

hold on
%Define Arrow.
x=[0 A A-0.1*A A A-0.1*A]';
y=[0 0 0.1*A 0 -0.1*A]';
%Rotate Arrow.
x1=x*cos(phi)-y*sin(phi);
y1=x*sin(phi)+y*cos(phi);
%Plot Arrow.
plot(x1,y1,c,'LineWidth',2)



%Draw dotted circle to show magnitude of error.
theta=0:0.1:2*pi;
plot(A*cos(theta),A*sin(theta),strvcat(c,':'));
grid
hold off
