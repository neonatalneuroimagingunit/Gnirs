function ForwardSymulation = loadforward(DBProbe)
if DBProbe.forwardFlag
    temp = load([DBProbe.path, 'ForwardSym'],'ForwardSymulation');
    ForwardSymulation = temp.ForwardSymulation;
else
    warning('there is no symulation')
    ForwardSymulation = NirsForward;
end
end
