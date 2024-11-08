n=[0:15];
input1=cos(n*pi/3);
input2=cos(3*n*pi/3);
% Linear if output1 = output2
%-------------------------------------------------
% 1a
%-------------------------------------------------

% System 1
output1=system1(input1) + system1(input2);
output2=system1(input1 + input2);

subplot(3,1,1)
hold on

title('System1');
xlabel('n')
ylabel('uutput')

stem(output1)
plot(output2)
hold off


% System 2
output1=system2(input1) + system2(input2);
output2=system2(input1 + input2);

subplot(3,1,2)
hold on

title('System2');
xlabel('n')
ylabel('output')

stem(output1);
plot(output2);
hold off


% System 3
output1=system3(input1) + system3(input2);
output2=system3(input1 + input2);

subplot(3,1,3)
hold on

title('System3');
xlabel('n')
ylabel('output')

stem(output1)
plot(output2)
hold off


%-------------------------------------------------
% 1b
%-------------------------------------------------
% figure(5)
% 
% n=[0:15];
 input1=cos(n*pi/3);
 input2=cos(3*n*pi/3);
% 
% output3=system2(input1+input2,n);
% stem(output3)
% figure(6)
% output2=system3(impz(input1 + input2));
% stem(output2)







