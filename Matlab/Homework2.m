dt = 1/100;
tt = -1 : dt : 1;
Fo = 2;
zz = 300*exp(j*(2*pi*Fo*(tt - 0.75)));
xx = real(zz);
%
plot( tt, xx), grid on
title('get some')
xlabel('Time    (sec)');