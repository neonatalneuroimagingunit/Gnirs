function ForwardSimulation = loadforward(DBProbe)
if DBProbe.forwardFlag
    temp = load([DBProbe.path, 'ForwardSim'],'ForwardSimulation');
    ForwardSimulation = temp.ForwardSimulation;
else
    warning('No forward simulation found')
    ForwardSimulation = NirsForward;
end
end
