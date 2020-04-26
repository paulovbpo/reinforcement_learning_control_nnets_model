% Reseting and generating random signals of reference
function in = localResetFcn(in)


% Range varying between 70 to 103 °C
blk = sprintf('rl_control_nnets_temperature/Temperature Reference');
h = 25*rand + 70
while h <= 27 || h >= 103
    h = 25*rand + 70;
end
in = setBlockParameter(in,blk,'Value',num2str(h));


end