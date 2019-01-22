function runforward(~, ~, GHandle)

Head = GHandle.TempWindow.DBAtlas.loadhead;
Scalp = GHandle.TempWindow.Atlas.Scalp;
Probe = GHandle.TempWindow.Probe;

nNeighbors = 100;

cfg.nphoton = str2double(GHandle.TempWindow.NPhoton.Value);

cfg.node = Head.node(:,1:3);
cfg.face = Head.face;
cfg.elem = Head.elem;
cfg.elemprop = ones(size(cfg.elem,1),1);

cfg.srctype = GHandle.TempWindow.SrcType.String(GHandle.TempWindow.SrcType.Value);
cfg.srcparam1 = 0; % Get from Ghandle
cfg.srcparam2 = 0; % Get from Ghandle

cfg.tstart = str2double(GHandle.TempWindow.TStart.String);
cfg.tend = str2double(GHandle.TempWindow.TEnd.String);
cfg.tstep = str2double(GHandle.TempWindow.TStep.String);

cfg.debuglevel = GHandle.TempWindow.DebugLevel.String; % Remove in future

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fukui 2013 - 800 nm - Human newborn
cfg.prop = [0.0000  0.00 1.0 1.0; ...     % Air
    0.0170 17.50 0.9 1.3; ...     % ECT
    0.0041  0.32 0.9 1.3; ...     % CSF
    0.0480  5.00 0.9 1.3; ...     % GM
    0.0370 10.00 0.9 1.3; ...     % WM
    0.0370 10.00 0.9 1.3; ...     % Brainstem
    0.0370 10.00 0.9 1.3];        % Cerebellum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cfg = mmclab(cfg,'prep');

nSrc = size(Probe.source.label,1);
nDet = size(Probe.detector.label,1);
nTot = nSrc + nDet;

fluxSrc = zeros(size(Head.node,1),nSrc);
fluxDet = zeros(size(Head.node,1),nDet);
t = zeros(nTot,1);

srcPos = Probe.source.position;
detPos = Probe.detector.position;
srcDir = zeros(size(srcPos));
detDir = zeros(size(detPos));

for iSrc = 1:1:nSrc
    tic
    cfg.srcpos = srcPos(iSrc,:);
    distScalp = vecnorm(Scalp.node - cfg.srcpos,2,2);
    [~, idxNeighbors] = sort(distScalp);
    idxNeighbors = idxNeighbors(1:nNeighbors);
    temp = Scalp.node(idxNeighbors,:);
    [eigenvectors, ~] = eig(temp'*temp);
    srcDir(iSrc,:) = eigenvectors(:,3);
    cfg.srcdir = srcDir(iSrc,:);
    fluxSrc(:,iSrc) = mmclab(cfg);
    t(iSrc) = toc;
end

for iDet = 1:1:nDet
    tic
    cfg.srcpos = detPos(iDet,:);
    distScalp = vecnorm(Scalp.node - cfg.srcpos,2,2);
    [~, idxNeighbors] = sort(distScalp);
    idxNeighbors = idxNeighbors(1:nNeighbors);
    temp = Scalp.node(idxNeighbors,:);
    [eigenvectors, ~] = eig(temp'*temp);
    detDir(iDet,:) = eigenvectors(:,3);
    cfg.srcdir = detDir(iDet,:);
    fluxDet(:,iDet) = mmclab(cfg);
    t(nSrc + iDet) = toc;
end

%% Save the results

cfg.srcpos = [];
cfg.srcdir = [];

settingsNote = sprintf('Total time %f s', sum(t));
settingsNote = char(settingsNote,['Partial Time:' num2str(t', '%f s')]);

ForwardSimulation = NirsForward(...
    'atlasId', GHandle.TempWindow.DBProbe.atlasId , ...
    'probeId', GHandle.TempWindow.DBProbe.id , ...
    'date', datetime, ...
    'node', Head.node, ...
    'src', srcPos, ...
    'det', detPos, ...
    'srcDir', srcDir, ...
    'detDir', detDir, ...
    'srcFlux', fluxSrc, ...
    'detFlux', fluxDet, ...
    'Settings', cfg,...
    'note', settingsNote);

save([GHandle.TempWindow.DBProbe.path,'ForwardSim'], 'ForwardSimulation');
probeMask = GHandle.DataBase.Probe == GHandle.TempWindow.DBProbe;
GHandle.DataBase.Probe(probeMask).forwardFlag = true;
GHandle.DataBase.save;

close(GHandle.TempWindow.SimulationFigure);
end