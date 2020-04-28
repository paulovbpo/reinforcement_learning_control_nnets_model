% Reducing the already normalized data
clc

flow_norm_redu = reduction(flow_norm);  % call another function that makes the reduction
figure(5)
plot(flow_norm_redu)
title('Step Reduced Input Flow') 
xlabel('Reduced Samples')
ylabel('Normalized Input Flow')


temp_norm_redu = reduction(temp_norm);  % call another function that makes the reduction
figure(6)
plot(temp_norm_redu)
title('Reduced Temperature Step Response') 
xlabel('Reduced Samples')
ylabel('Temperature Normalized')

