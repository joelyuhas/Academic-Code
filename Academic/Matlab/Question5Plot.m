fp = fplot(@(t) sin(3*(t-4))./(3*(t-4)), [0,8]);
grid on
title("Question 5");
xlabel("x axis");
ylabel("y axis");
legend("y = sin(3(t-4))/(3(t-4))");
fp.Marker = 'x';
