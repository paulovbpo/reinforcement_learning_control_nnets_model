% Testing the trained agent as a Controller
clc

figure(1)
plot(test_1(:,1),'-- k', 'LineWidth',[1.2])
hold on
plot(test_1(:,2),'r')
title('Temperature Step Response') 
xlabel('Time [s]')
ylabel('Temperature [°C]')
legend('Reference','Controlled Temperature')
axis([0 300 68 98])

figure(2)
plot(test_2(:,1),'-- k', 'LineWidth',[1.2])
hold on
plot(test_2(:,2),'r')
title('Temperature Step Response') 
xlabel('Time [s]')
ylabel('Temperature [°C]')
legend('Reference','Controlled Temperature')
axis([0 300 68 98])

figure(3)
plot(test_3(:,1),'-- k', 'LineWidth',[1.2])
hold on
plot(test_3(:,2),'r')
title('Temperature Step Response') 
xlabel('Time [s]')
ylabel('Temperature [°C]')
legend('Reference','Controlled Temperature')
axis([0 300 68 98])

figure(4)
plot(test_4(:,1),'-- k', 'LineWidth',[1.2])
hold on
plot(test_4(:,2),'r')
title('Temperature Step Response') 
xlabel('Time [s]')
ylabel('Temperature [°C]')
legend('Reference','Controlled Temperature')
axis([0 300 68 98])


% Mean squared error
mse(test_1)
mse(test_2)
mse(test_3)
mse(test_4)


