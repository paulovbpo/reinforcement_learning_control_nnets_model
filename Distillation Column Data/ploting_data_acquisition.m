% Analisando 1° Coleta de Dados da Coluna de Destilação - Sem Tratamento
clc

t = [0 : 0.5 : 2951];

figure(1)
plot(t,input_flow.signals.values)
title('Step Input Flow') 
xlabel('Time [s]')
ylabel('Input Flow [l/h]')

figure(2)
plot(t,temperature.signals.values)
title('Temperature Step Response') 
xlabel('Time [s]')
ylabel('Temperature [°C]')



temp = temperature.signals.values;
flow = input_flow.signals.values;
