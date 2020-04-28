% Delaying the data to generate new inputs to the neural network
clc

flow_delay = delay(flow_norm_redu);  % call another function that makes the delay

figure(7)
plot(flow_delay)
hold on
plot(flow_norm_redu)
title('Step Delayed Input Flow') 
xlabel('Reduced Samples')
ylabel('Normalized Input Flow')


temp_norm_redu = double(temp_norm_redu);   % converting the variable to double
temp_delay = delay(temp_norm_redu); % call another function that makes the delay

figure(8)
plot(temp_delay)
hold on
plot(temp_norm_redu)
title('Delayed Temperature Step Response') 
xlabel('Reduced Samples')
ylabel('Temperature Normalized')


inputs = [flow_norm_redu; flow_delay; temp_delay]; 