% Testing the Trained Neural Network
clc

% Plotting the comparison between the real system data and the neural network model
figure(9)
plot(network1_outputs{1,1}, '--','linewidth',2)
hold on
plot(temp_norm_redu)
legend('Neural Network Model','Real System Data')
title('Temperature Comparison Between the Real System Data and the Neural Network Output') 
xlabel('Time [s]')
ylabel('Temperature [°C]')

% Model performance measure by MSE index
e = (network1_outputs{1,1} - temp_norm_redu);
mse(e)