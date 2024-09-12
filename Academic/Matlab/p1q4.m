%---------------------------------------------
% Project 1
% Joel Yuhas
% 10/12/18
%
% QUESTION 2
%
%---------------------------------------------


clear

%---------------------------------------------
% a-b) x(t)
%---------------------------------------------
Trep=1e-6;
t1=[0:Trep:.01];

f_tone1=1000;                   % default frequency

xt=.5*cos(2*pi*f_tone1*t1).*cos(2*pi*3000*t1);     % x(t)
f2=9000;                        % Sampling Frequeny

figure(1);
plot(t1,xt)
title('x(t)')
xlabel('Time(s)')
ylabel('Amplitude')
grid


%---------------------------------------------
% c) X(jw)
%---------------------------------------------
signal1_sp=fft(xt);
signal1_sp_sf=fftshift(signal1_sp);
%Absolute value unit
signal1_sp_sf(find(abs(signal1_sp_sf)<3))=0;
f_axis=linspace(-1/Trep/2,1/Trep/2,length(signal1_sp_sf));

figure(2);
plot(f_axis,abs(signal1_sp_sf));
title('X(jw)');
xlabel('Time(s)')
ylabel('Amplitude')


%---------------------------------------------
% d-e) xs(t)
%---------------------------------------------

t2=[0:1/f2:10*1/f_tone1];
%t2=[0:Trep:.01];
xs=.5*cos(2*pi*f_tone1*t2).*cos(2*pi*3000*t2); 


figure(3);
subplot(2,1,1);
plot(t1,xt);
title('xs(t)');
hold on;
stem(t2,xs);
xlabel('Time(s)')
ylabel('Amplitude')




%---------------------------------------------
% f) Xs(jw)
%---------------------------------------------
signal1_sp=fft(xs);
signal1_sp_sf=fftshift(signal1_sp);
%Absolute value unit
signal1_sp_sf(find(abs(signal1_sp_sf)<1))=0;
f_axis=linspace(-1/Trep/2,1/Trep/2,length(signal1_sp_sf));
figure(4);
plot(f_axis,abs(signal1_sp_sf));
title('Xs(jw)');
xlabel('Time(s)')
ylabel('Amplitude')

%---------------------------------------------
%g) Lowpass filter
%---------------------------------------------
y = lowpass(signal1_sp_sf,pi*f2,f_tone1);



%---------------------------------------------
% h) Xr(jw)
%---------------------------------------------

figure(5);
plot(f_axis,abs(y));
title('Xr(jw)');
xlabel('Time(s)')
ylabel('Amplitude')


%---------------------------------------------
% i) xr(t)
%---------------------------------------------
%iff block functiond
z= inverseblock(y);
figure(6);
plot(f_axis,z);
title("xr(t)");




%---------------------------------------------
% scalled pit
%---------------------------------------------
Scaled_out=max(xt)/max(z)*z;





%iffblock function
function f = inverseblock(n)
    signal1_sp_asf=ifftshift(n);
    signal1_rec=ifft(signal1_sp_asf);
    f = signal1_rec;
end



