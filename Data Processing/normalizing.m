% Normalizing the data of temperature and input flow using a range 0 to 1
clc

flow_norm = normalize(flow,'range');
temp_norm = normalize(temp,'range');

figure(3)
plot(t,flow_norm)
title('Step Normalized Input Flow') 
xlabel('Time [s]')
ylabel('Normalized Input Flow')

figure(4)
plot(t,temp_norm)
title('Normalized Temperature Step Response') 
xlabel('Time [s]')
ylabel('Temperature Normalized')

