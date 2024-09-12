t = -4:0.001:4;
n = -10:10;
Fo = 1;
Xn = 1j./(2*pi*n);
Xn(n==0) = 1/2;
x = Xn * exp(-(1j*2*pi*n'*Fo*t));
plot(t,abs(x))