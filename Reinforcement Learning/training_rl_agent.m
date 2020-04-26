% Training the Reinforcement Learning agent at a Neural Network model of a Distillation Column
% The input of the Distillation Column is input flow and the output is temperature
clc

% Creating the enviroment
obsInfo = rlNumericSpec([3 1],...
    'LowerLimit',[-inf -inf -inf ]',...
    'UpperLimit',[ inf  inf inf ]');
obsInfo.Name = 'Observations';
obsInfo.Description = 'Integrator; Error; Temperature';

% Generating the agent actions
actInfo = rlNumericSpec([1 1],'LowerLimit',[0],'UpperLimit',[1]);
actInfo.Name = 'Input Flow';
numActions = actInfo.Dimension(1);

% Defining the enviroment  
model = 'rl_control_nnets_temperature';
agent = 'rl_control_nnets_temperature/Agent';

env = rlSimulinkEnv(model, agent, obsInfo, actInfo);

% Function that reset and generate new random values of reference
 env.ResetFcn = @(in)localResetFcn(in);

% Specifying the simulation time (Tf) and the agent's sample time (Ts)
Tf = 20;
Ts = 0.1;

% Fixing the seed of random generator
rng(10)

% Creating the Critic neural network, with 2 input layers, observations and actions, and 1 output
statePath = [
    imageInputLayer([3 1 1],'Normalization','none','Name','State')
    fullyConnectedLayer(150,'Name','CriticStateFC1') 
    reluLayer('Name','CriticRelu1')
    fullyConnectedLayer(150,'Name','CriticStateFC2')
    reluLayer('Name','CriticRelu2')
    fullyConnectedLayer(150,'Name','CriticStateFC3')];

actionPath = [
    imageInputLayer([numActions 1 1],'Normalization','none','Name','Action')
    fullyConnectedLayer(150,'Name','CriticActionFC1')];

commonPath = [
    additionLayer(2,'Name','add')
    reluLayer('Name','CriticCommonRelu')
    fullyConnectedLayer(1,'Name','CriticOutput')];

criticNetwork = layerGraph();
criticNetwork = addLayers(criticNetwork,statePath);
criticNetwork = addLayers(criticNetwork,actionPath);
criticNetwork = addLayers(criticNetwork,commonPath);
criticNetwork = connectLayers(criticNetwork,'CriticStateFC3','add/in1');
criticNetwork = connectLayers(criticNetwork,'CriticActionFC1','add/in2');


% Specifying the Critic representation options 
criticOpts = rlRepresentationOptions('LearnRate',5e-03,'GradientThreshold',1);
critic = rlRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'State'},'Action',{'Action'},criticOpts);


% Creating the Actor neural network, using the observations as input layers
actorNetwork = [
    imageInputLayer([3 1 1],'Normalization','none','Name','observation')
    fullyConnectedLayer(150, 'Name','actorFC1') 
    reluLayer('Name','ActorRelu1')
    fullyConnectedLayer(150, 'Name','actorFC2')
    reluLayer('Name','ActorRelu2')
    fullyConnectedLayer(1, 'Name','actorFC3')
    tanhLayer('Name','actorTanh')
    scalingLayer('Name','ActorScaling1','Scale',0.7,'Bias',0.3)];

actorOptions = rlRepresentationOptions('LearnRate',1e-3,'GradientThreshold',1,'L2RegularizationFactor',1e-4);
actor = rlRepresentation(actorNetwork,obsInfo,actInfo,...
    'Observation',{'observation'},'Action',{'ActorScaling1'},actorOptions);

% Specifying the options to create the Agent using DDPG algorithm (Deep Deterministic Policy Gradiente) 
agentOpts = rlDDPGAgentOptions(...
    'SampleTime',Ts,...
    'TargetSmoothFactor',1e-3,...
    'DiscountFactor',0.99, ...
    'MiniBatchSize',64, ...
    'ExperienceBufferLength',1e6); 
agentOpts.NoiseOptions.Variance = 0.2;
agentOpts.NoiseOptions.VarianceDecayRate = 1e-5;

% Making the Agent with the representations of the Actor, Critic and Agent's options.
agent = rlDDPGAgent(actor,critic,agentOpts);

% Training the Agent
% Specifying the training functions 
maxepisodes = 6000;
maxsteps = ceil(Tf/Ts);
trainOpts = rlTrainingOptions(...
    'MaxEpisodes',maxepisodes, ...
    'MaxStepsPerEpisode',maxsteps, ...
    'ScoreAveragingWindowLength',20, ...
    'Verbose',false, ...
    'Plots','training-progress',...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',1000);

doTraining = false;   % true if want to train a new agent, or false to load a trained one
if doTraining
    % Training a new agent
    trainingStats = train(agent,env,trainOpts);
    save("agente_modelo_temp_18.mat",'agent')
else
    % Loading an agent
    load('C:\Users\paulo\Documents\PV\Engenharia de Controle e Automação\TCC\Desenvolvimento\Controlador\Controlador Temperatura\Imagens do Simulink do Melhor Controlador 2\agente_modelo_temp_5','agent')
end