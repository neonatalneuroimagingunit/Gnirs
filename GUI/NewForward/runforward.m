function runforward(~, ~, GHandle)

fw = 1;

Head = GHandle.TempWindow.DBAtlas.loadhead;
Scalp = GHandle.TempWindow.Atlas.Scalp;
Probe = GHandle.TempWindow.Probe;

nNeighbors = 100;

cfg.nphoton = str2double(GHandle.TempWindow.NPhoton.String);

cfg.node = Head.node(:,1:3);
%cfg.face = Head.face; probably not needed (mmclab raises a "redundant" warning)
cfg.elem = Head.elem;
cfg.elemprop = ones(size(cfg.elem,1),1);

cfg.srctype = GHandle.TempWindow.SrcType.String{GHandle.TempWindow.SrcType.Value};
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

nSrc = size(Probe.source.label,1);
nDet = size(Probe.detector.label,1);
nTot = nSrc + nDet;

fluxSrc = zeros(size(Head.node,1),nSrc);
fluxDet = zeros(size(Head.node,1),nDet);
tP = zeros(nTot,1);
tS = zeros(nTot,1);

srcPosOrig = Probe.source.position;
detPosOrig = Probe.detector.position;
srcPos = zeros(size(srcPosOrig));
detPos = zeros(size(detPosOrig));
srcDir = zeros(size(srcPosOrig));
detDir = zeros(size(detPosOrig));

%% Calculate srcpos (refinement)
tic

nElem = size(Head.elem,1);
cdm = zeros(nElem,3);
for iElem = 1:1:nElem
    cdm(iElem,:) = (...
        Head.node(Head.elem(iElem,1),1:3) + ...
        Head.node(Head.elem(iElem,2),1:3) + ...
        Head.node(Head.elem(iElem,3),1:3) + ...
        Head.node(Head.elem(iElem,4),1:3)) / 4;
end

for iSrc = 1:1:nSrc
    distCdm = vecnorm(cdm - srcPosOrig(iSrc,:),2,2);
    [~, idxNeighbors] = sort(distCdm);
    srcPos(iSrc,:) = cdm(idxNeighbors(1),:);
end

for iDet = 1:1:nDet
    distCdm = vecnorm(cdm - detPosOrig(iDet,:),2,2);
    [~, idxNeighbors] = sort(distCdm);
    detPos(iDet,:) = cdm(idxNeighbors(1),:);
end

tR = toc;

%% Calculate srcdir
tic

for iSrc = 1:1:nSrc
    tic
    distScalp = vecnorm(Scalp.node - srcPos(iSrc,:),2,2);
    [~, idxNeighbors] = sort(distScalp);
    idxNeighbors = idxNeighbors(1:nNeighbors);
    temp = Scalp.node(idxNeighbors,:);
    [eigenvectors, ~] = eig(temp'*temp);
    srcDir(iSrc,:) = -eigenvectors(:,3)';
    tP(iSrc) = toc;
end

for iDet = 1:1:nDet
    tic
    distScalp = vecnorm(Scalp.node - detPos(iDet,:),2,2);
    [~, idxNeighbors] = sort(distScalp);
    idxNeighbors = idxNeighbors(1:nNeighbors);
    temp = Scalp.node(idxNeighbors,:);
    [eigenvectors, ~] = eig(temp'*temp);
    detDir(iDet,:) = -eigenvectors(:,3)';
    tP(nSrc + iDet) = toc;
end

tD = toc;

%% Plot srcpos and srcdir over anatomy
figure
hold on
trisurf(Scalp.face,...
    Scalp.node(:,1),Scalp.node(:,2),Scalp.node(:,3),...
    ones(size(Scalp.node(:,3))),...
    'SpecularStrength', 0, ...
    'EdgeColor','none',...
    'FaceColor',[0.7 0.7 0.7],...
    'FaceAlpha',0.3);
light('Position',[100 0 100]);     % x is left->right, y is back->front
light('Position',[-100 0 100]);
axis equal
axis off
axis vis3d
plot3(srcPosOrig(:,1),srcPosOrig(:,2),srcPosOrig(:,3),'*r', 'MarkerSize',10)
plot3(detPosOrig(:,1),detPosOrig(:,2),detPosOrig(:,3),'*b', 'MarkerSize',10)
plot3(srcPos(:,1),srcPos(:,2),srcPos(:,3),'.r', 'MarkerSize',10)
plot3(detPos(:,1),detPos(:,2),detPos(:,3),'.b', 'MarkerSize',10)
for iSrc = 1:1:nSrc
    frecciona2(srcPos(iSrc,:), srcPos(iSrc,:)+10*srcDir(iSrc,:),'Size',[20 0.3],'Color',[1 0 0]);
end
for iDet = 1:1:nDet
    frecciona2(detPos(iDet,:), detPos(iDet,:)+10*detDir(iDet,:),'Size',[20 0.3],'Color',[0 0 1]);
end

%% Run forward simulation
if fw
    %cfg.srcpos = srcPos(1,:);
    %cfg.srcdir = srcDir(1,:);
    %cfg = mmclab(cfg, 'prep');
    
    for iSrc = 1:1:nSrc
        tic
        cfg.srcpos = srcPos(iSrc,:);
        cfg.srcdir = srcDir(iSrc,:);
        tempflux = mmclab(cfg);
        if ~isempty(tempflux.data)
            fluxSrc(:,iSrc) = sum(tempflux.data,2);
        end
        tS(iSrc) = toc;
    end
    
    for iDet = 1:1:nDet
        tic
        cfg.srcpos = detPos(iDet,:);
        cfg.srcdir = detDir(iDet,:);
        tempflux = mmclab(cfg);
        if ~isempty(tempflux.data)
            fluxDet(:,iDet) = sum(tempflux.data,2);
        end
        tS(nSrc + iDet) = toc;
    end
    
    %% Save the results
    cfg.srcpos = [];
    cfg.srcdir = [];
    
    settingsNote = sprintf('Total time %f s', tR + tD + sum(tP)+sum(tS));
    settingsNote = char(settingsNote,['SrcPos time:' num2str(tR, '%f s')]);
    settingsNote = char(settingsNote,['SrcDir time:' num2str(tD, '%f s')]);
    settingsNote = char(settingsNote,['Preparation time:' num2str(tP', '%f s')]);
    settingsNote = char(settingsNote,['Simulation time:' num2str(tS', '%f s')]);
    
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
end

%% Close temp window
close(GHandle.TempWindow.SimulationFigure);
end