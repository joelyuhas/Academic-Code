%input should return original stem
input = [1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
output = Project2Filter(30,input);
figure(1);
stem(output);
figure(2);
freqz(output);