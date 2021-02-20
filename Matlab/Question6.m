x = [0 1 2 3 4 5 6 7 8 9 10];
y = [];
j = 0;

for i = x
    j = 0.5^i;
    y = [y ; j];    
end
   
stem(y);
grid on;
xlabel("x axis");
ylabel("y axis");