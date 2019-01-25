function runforward(~, ~, GHandle)

GHandle.TempWindow.ProgressRectangleBG.String = 'Starting...';
drawnow;

fw = ~GHandle.TempWindow.Test.Value;

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

cfg.debuglevel = GHandle.TempWindow.DebugLevel.String; % Remove in future, if empty mmclab returns an error
if isempty(cfg.debuglevel)
    cfg.debuglevel = 'T';
end

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
tS = zeros(nTot,1);

srcPosOrig = Probe.source.position;
detPosOrig = Probe.detector.position;
srcPos = zeros(size(srcPosOrig));
detPos = zeros(size(detPosOrig));
srcDir = zeros(size(srcPosOrig));
detDir = zeros(size(detPosOrig));

%% Calculate srcpos (refinement)
tic
cdm = mean(cat(3,...
    Head.node(Head.elem(:,1),1:3),...
    Head.node(Head.elem(:,2),1:3),...
    Head.node(Head.elem(:,3),1:3),...
    Head.node(Head.elem(:,4),1:3)),...
    3);

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


%%
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

%% Calculate srcdir
tic
centroid = mean(Scalp.node(:,1:3),1);
for iSrc = 1:1:nSrc
    distScalp = vecnorm(Scalp.node - srcPos(iSrc,:),2,2);
    [~, idxNeighbors] = sort(distScalp);
    idxNeighbors = idxNeighbors(1:nNeighbors);
    temp = Scalp.node(idxNeighbors,:);
    temp = temp - mean(temp,1);
    [eigenvectors, ~] = eig(temp'*temp);
    srcDir(iSrc,:) = sign(dot(centroid-srcPos(iSrc,:),eigenvectors(:,1)'))*eigenvectors(:,1)';
end

for iDet = 1:1:nDet
    distScalp = vecnorm(Scalp.node - detPos(iDet,:),2,2);
    [~, idxNeighbors] = sort(distScalp);
    idxNeighbors = idxNeighbors(1:nNeighbors);
    temp = Scalp.node(idxNeighbors,:);
    temp = temp - mean(temp,1);
    [eigenvectors, ~] = eig(temp'*temp);
    detDir(iDet,:) = sign(dot(centroid-detPos(iDet,:),eigenvectors(:,1)'))*eigenvectors(:,1)';
end
tD = toc;

%% Plot srcpos and srcdir over anatomy

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
        GHandle.TempWindow.ProgressRectangleBG.String = [num2str(iSrc) '/' num2str(nTot) '...'];
        drawnow;
        cfg.srcpos = srcPos(iSrc,:);
        cfg.srcdir = srcDir(iSrc,:);
        tempflux = mmclab(cfg);
        if ~isempty(tempflux.data)
            fluxSrc(:,iSrc) = sum(tempflux.data,2);
        end
        GHandle.TempWindow.ProgressRectangleFG.Position(3) = 0.8*(iSrc/nTot);
        drawnow;
        tS(iSrc) = toc;
    end
    
    for iDet = 1:1:nDet
        tic
        GHandle.TempWindow.ProgressRectangleBG.String = [num2str(nSrc+iDet) '/' num2str(nTot) '...'];
        drawnow;
        cfg.srcpos = detPos(iDet,:);
        cfg.srcdir = detDir(iDet,:);
        tempflux = mmclab(cfg);
        if ~isempty(tempflux.data)
            fluxDet(:,iDet) = sum(tempflux.data,2);
        end
        GHandle.TempWindow.ProgressRectangleFG.Position(3) = 0.8*((nSrc+iDet)/nTot);
        drawnow;
        tS(nSrc + iDet) = toc;
    end
    
    %% Save the results
    cfg.srcpos = [];
    cfg.srcdir = [];
    
    Timing.total = tR + tD +sum(tS);
    Timing.srcpos = tR;
    Timing.srcdir = tD;
    Timing.simulation = sum(tS);
    Timing.simulationAvg = mean(tS);
    
    settingsNote = '';
    
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
        'Timing', Timing, ...
        'note', settingsNote);
    
    save([GHandle.TempWindow.DBProbe.path,'ForwardSim'], 'ForwardSimulation');
    probeMask = GHandle.DataBase.Probe == GHandle.TempWindow.DBProbe;
    GHandle.DataBase.Probe(probeMask).forwardFlag = true;
    GHandle.DataBase.save;
end

%% Close temp window
close(GHandle.TempWindow.SimulationFigure);
end