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

A=1e-3;
raiseindex=max(find(t1<A));
decayindex=max(find(t1<2*A));
xt=zeros(size(t1));
xt(1:raiseindex)=t1(1:raiseindex)/A;
xt(raiseindex+1:decayindex)=1-t1(1:raiseindex)/A;  

f2=7000;                        % Sampling Frequeny

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


raiseindex=max(find(t2<A));
decayindex=max(find(t2<2*A));
xs=zeros(size(t2));
xs(1:raiseindex)=t2(1:raiseindex)/A;
xs(raiseindex+1:decayindex)=1-t2(1:raiseindex)/A; 

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
f_axis=linspace(-1/Trep/2,1/Trep/2,length(signal1_sp_sf));
figure(4);
plot(f_axis,abs(signal1_sp_sf));
title('Xs(jw)');
xlabel('Time(s)')
ylabel('Amplitude')

%---------------------------------------------
%g) Lowpass filter
%---------------------------------------------
y = lowpass(xs,pi*f2,f_tone1);



%---------------------------------------------
% h) Xr(jw)
%---------------------------------------------
signal1_sp=fft(y);
signal1_sp_sf=fftshift(signal1_sp);
f_axis=linspace(-1/Trep/2,1/Trep/2,length(signal1_sp_sf));
figure(5);
plot(f_axis,abs(signal1_sp_sf));
title('Xr(jw)');
xlabel('Time(s)')
ylabel('Amplitude')


%---------------------------------------------
% i) xr(t)
%---------------------------------------------
%iff block function
z= inverseblock(signal1_sp);
figure(6);
plot(f_axis,abs(z));
title("xr(t)");
xlabel('Time(s)')
ylabel('Amplitude')

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



