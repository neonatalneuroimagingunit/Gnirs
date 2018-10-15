function tenFive = atlas105maker(Atlas,nStep)
tenFive.names = {};
tenFive.coord = zeros(21,21,3);
tenFive.neighbors = {};


Nz = Atlas.LandMarks.coordinates(1,:);
Iz = Atlas.LandMarks.coordinates(2,:);
RPA = Atlas.LandMarks.coordinates(3,:);
LPA = Atlas.LandMarks.coordinates(4,:);
Cz = Atlas.LandMarks.coordinates(5,:);
meshPoints = Atlas.Scalp.node;


%% find Iz-Cz-Nz line
[pathIzCzNzPoints, ~, pathIzCzNzrelativeLength] = pathonmesh(meshPoints, Iz, Cz , Nz, nStep);
main_BackFront_Points = pointsrelpos(pathIzCzNzPoints, pathIzCzNzrelativeLength, 0:0.05:1);

%% find RPA-Cz-LPA line
[pathRPACzLPAPoints, ~, pathRPACzLPArelativeLength] = pathonmesh(meshPoints, RPA, Cz , LPA, nStep);
T9  = pointsrelpos(pathRPACzLPAPoints, pathRPACzLPArelativeLength, 0.9);
T10 = pointsrelpos(pathRPACzLPAPoints, pathRPACzLPArelativeLength, 0.1);

%% find  T10-Cz-T9  line
[pathT10CzT9Points, ~, pathT10CzT9relativeLength] = pathonmesh(meshPoints, T10, Cz , T9, nStep);
main_RightLeft_Points = pointsrelpos(pathT10CzT9Points, pathT10CzT9relativeLength, 0:0.05:1);

%% find  Main points
%Nz = main_BackFront_Points(1,:);
OIz = main_BackFront_Points(2,:);
Oz = main_BackFront_Points(3,:);
POOz = main_BackFront_Points(4,:);
POz = main_BackFront_Points(5,:);
PPOz = main_BackFront_Points(6,:);
Pz = main_BackFront_Points(7,:);
CPPz = main_BackFront_Points(8,:);
CPz = main_BackFront_Points(9,:);
CCPz = main_BackFront_Points(10,:);
%CZ = main_BackFront_Points(11,:);
FCCz = main_BackFront_Points(12,:);
FCz = main_BackFront_Points(13,:);
FFCz = main_BackFront_Points(14,:);
Fz = main_BackFront_Points(15,:);
AFFz = main_BackFront_Points(16,:);
AFz = main_BackFront_Points(17,:);
AFpz = main_BackFront_Points(18,:);
FPz = main_BackFront_Points(19,:);
NFpz = main_BackFront_Points(20,:);
%Iz = main_BackFront_Points(21,:);
T9h = main_RightLeft_Points(20,:);
T7 = main_RightLeft_Points(19,:);
T10h = main_RightLeft_Points(2,:);
T8 = main_RightLeft_Points(3,:);

%% find  Oz-T7-FPz line
[pathOzT7FPzPoints, ~, pathOzT7FPzrelativeLength] = pathonmesh(meshPoints, Oz, T7 , FPz, nStep);
secondaryBackFrontPoints = pointsrelpos(pathOzT7FPzPoints, pathOzT7FPzrelativeLength,0:0.05:1);
%% find  FPz-T8-Oz line
[pathFPZT8OzPoints, ~, pathFPZT8OzrelativeLength] = pathonmesh(meshPoints, Oz, T8 , FPz, nStep);
secondaryFrontBackPoints = pointsrelpos(pathFPZT8OzPoints, pathFPZT8OzrelativeLength,1:-0.05:0);

%% assign main Points
%Fpz = secondaryBackFrontPoints(21,:);
%Fp1h = secondaryBackFrontPoints(20,:);
%Fp1 = secondaryBackFrontPoints(19,:);
AFp7 = secondaryBackFrontPoints(18,:);
AF7 = secondaryBackFrontPoints(17,:);
AFF7 = secondaryBackFrontPoints(16,:);
F7 = secondaryBackFrontPoints(15,:);
FFT7 = secondaryBackFrontPoints(14,:);
FT7 = secondaryBackFrontPoints(13,:);
FTT7 = secondaryBackFrontPoints(12,:);
%T7 = secondaryBackFrontPoints(11,:);
TTP7 = secondaryBackFrontPoints(10,:);
TP7 = secondaryBackFrontPoints(9,:);
TPP7 = secondaryBackFrontPoints(8,:);
P7 = secondaryBackFrontPoints(7,:);
PPO7 = secondaryBackFrontPoints(6,:);
PO7 = secondaryBackFrontPoints(5,:);
POO7 = secondaryBackFrontPoints(4,:);
%O1 = secondaryBackFrontPoints(3,:);
%O1h = secondaryBackFrontPoints(2,:);
%Oz = secondaryBackFrontPoints(1,:);

%Fpz = secondaryFrontBackPoints(1,:);
%Fp2h = secondaryFrontBackPoints(2,:);
%Fp2 = secondaryFrontBackPoints(3,:);
AFp8 = secondaryFrontBackPoints(4,:);
AF8 = secondaryFrontBackPoints(5,:);
AFF8 = secondaryFrontBackPoints(6,:);
F8 = secondaryFrontBackPoints(7,:);
FFT8 = secondaryFrontBackPoints(8,:);
FT8 = secondaryFrontBackPoints(9,:);
FTT8 = secondaryFrontBackPoints(10,:);
%T8 = secondaryFrontBackPoints(11,:);
TTP8 = secondaryFrontBackPoints(12,:);
TP8 = secondaryFrontBackPoints(13,:);
TPP8 = secondaryFrontBackPoints(14,:);
P8 = secondaryFrontBackPoints(15,:);
PPO8 = secondaryFrontBackPoints(16,:);
PO8 = secondaryFrontBackPoints(17,:);
POO8 = secondaryFrontBackPoints(18,:);
%O2 = secondaryFrontBackPoints(19,:);
%O2h = secondaryFrontBackPoints(10,:);
%Oz = secondaryFrontBackPoints(1,:);




%% Landmarks names for main circumferences
% Left
tenFive.names(:,1) = {'Nz'; 'N1h'; 'N1'; 'AFp9'; 'AF9'; 'AFF9'; 'F9'; 'FFT9'; 'FT9'; 'FTT9'; ...
    'T9'; 'TTP9'; 'TP9'; 'TPP9'; 'P9'; 'PPO9'; 'PO9'; 'POO9'; 'I1'; 'I1h'; 'Iz'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, Iz, T9 , Nz, nStep);
tenFive.coord(:,1,:) = pointsrelpos(tempPoints, tempLength, 1:(-0.05):0);

tenFive.names(:,2) = {'NFpz'; 'NFp1h'; 'NFp1'; 'AFp9h'; 'AF9h'; 'AFF9h'; 'F9h'; 'FFT9h'; 'FT9h'; 'FTT9h'; ...
    'T9h'; 'TTP9h'; 'TP9h'; 'TPP9h'; 'P9h'; 'PPO9h'; 'PO9h'; 'POO9h'; 'O1h'; 'OI1h'; 'OIz'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, OIz, T9h , NFpz, nStep);
tenFive.coord(:,2,:) = pointsrelpos(tempPoints, tempLength, 1:(-0.05):0);

tenFive.names(:,3) = {'Fpz'; 'Fp1h'; 'Fp1'; 'AFp7'; 'AF7'; 'AFF7'; 'F7'; 'FFT7'; 'FT7'; 'FTT7'; ...
    'T7'; 'TTP7'; 'TP7'; 'TPP7'; 'P7'; 'PPO7'; 'PO7'; 'POO7'; 'O1'; 'O1h'; 'Oz'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, Oz, T7 , FPz, nStep);
tenFive.coord(:,3,:) = pointsrelpos(tempPoints, tempLength, 1:(-0.05):0);

% Right
tenFive.names(:,21) = {'Nz'; 'N2h'; 'N2'; 'AFp10'; 'AF10'; 'AFF10'; 'F10'; 'FFT10'; 'FT10'; 'FTT10'; ...
    'T10'; 'TTP10'; 'TP10'; 'TPP10'; 'P10'; 'PPO10'; 'PO10'; 'POO10'; 'I2'; 'I2h'; 'Iz'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, Iz, T10 , Nz, nStep);
tenFive.coord(:,21,:) = pointsrelpos(tempPoints, tempLength, 1:-0.05:0);

tenFive.names(:,20) = {'NFpz'; 'NFp2h'; 'NFp2'; 'AFp10h'; 'AF10h'; 'AFF10h'; 'F10h'; 'FFT10h'; 'FT10h'; 'FTT10h'; ...
    'T10h'; 'TTP10h'; 'TP10h'; 'TPP10h'; 'P10h'; 'PPO10h'; 'PO10h'; 'POO10h'; 'O2h'; 'OI2h'; 'OIz'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, OIz, T10h , NFpz, nStep);
tenFive.coord(:,20,:) = pointsrelpos(tempPoints, tempLength, 1:-0.05:0);

tenFive.names(:,19) = {'Fpz'; 'Fp2h'; 'Fp2'; 'AFp8'; 'AF8'; 'AFF8'; 'F8'; 'FFT8'; 'FT8'; 'FTT8'; ...
    'T8'; 'TTP8'; 'TP8'; 'TPP8'; 'P8'; 'PPO8'; 'PO8'; 'POO8'; 'O2'; 'O2h'; 'Oz'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, Oz, T8 , FPz, nStep);
tenFive.coord(:,19,:) = pointsrelpos(tempPoints, tempLength, 1:-0.05:0);

%% Landmarks for arcs
arcPerc = 0.9375:-0.0625:0.0625;
%AF7
tenFive.names(4,4:18) = {'AFp7h'; 'AFp5'; 'AFp5h'; 'AFp3'; 'AFp3h'; 'AFp1'; 'AFp1h'; ...
    'AFpz'; 'AFp2h'; 'AFp2'; 'AFp4h'; 'AFp4'; 'AFp6h'; 'AFp6'; 'AFp8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, AFp8, AFpz , AFp7, nStep);
tenFive.coord(4,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(5,4:18) = {'AF7h'; 'AF5'; 'AF5h'; 'AF3'; 'AF3h'; 'AF1'; 'AF1h'; ...
    'AFz'; 'AF2h'; 'AF2'; 'AF4h'; 'AF4'; 'AF6h'; 'AF6'; 'AF8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, AF8, AFz , AF7, nStep);
tenFive.coord(5,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(6,4:18) = {'AFF7h'; 'AFF5'; 'AFF5h'; 'AFF3'; 'AFF3h'; 'AFF1'; 'AFF1h'; ...
    'AFFz'; 'AFF2h'; 'AFF2'; 'AFF4h'; 'AFF4'; 'AFF6h'; 'AFF6'; 'AFF8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, AFF8, AFFz , AFF7, nStep);
tenFive.coord(6,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(7,4:18) = {'F7h'; 'F5'; 'F5h'; 'F3'; 'F3h'; 'F1'; 'F1h'; ...
    'Fz'; 'F2h'; 'F2'; 'F4h'; 'F4'; 'F6h'; 'F6'; 'F8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, F8, Fz , F7, nStep);
tenFive.coord(7,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(8,4:18) = {'FFT7h'; 'FFC5'; 'FFC5h'; 'FFC3'; 'FFC3h'; 'FFC1'; 'FFC1h'; ...
    'FFCz'; 'FFC2h'; 'FFC2'; 'FFC4h'; 'FFC4'; 'FFC6h'; 'FFC6'; 'FFT8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, FFT8, FFCz , FFT7, nStep);
tenFive.coord(8,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(9,4:18) = {'FT7h'; 'FC5'; 'FC5h'; 'FC3'; 'FC3h'; 'FC1'; 'FC1h'; ...
    'FCz'; 'FC2h'; 'FC2'; 'FC4h'; 'FC4'; 'FC6h'; 'FC6'; 'FT8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, FT8, FCz , FT7, nStep);
tenFive.coord(9,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(10,4:18) = {'FTT7h'; 'FCC5'; 'FCC5h'; 'FCC3'; 'FCC3h'; 'FCC1'; 'FCC1h'; ...
    'FCCz'; 'FCC2h'; 'FCC2'; 'FCC4h'; 'FCC4'; 'FCC6h'; 'FCC6'; 'FTT8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, FTT8, FCCz , FTT7, nStep);
tenFive.coord(10,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

% main Cz arc
tenFive.names(11,4:18) = {'T7h'; 'C5'; 'C5h'; 'C3'; 'C3h'; 'C1'; 'C1h'; ...
    'Cz'; 'C2h'; 'C2'; 'C4h'; 'C4'; 'C6h'; 'C6'; 'T8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, T8, Cz , T7, nStep);
tenFive.coord(11,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

%dsfsd
tenFive.names(12,4:18) = {'TTP7h'; 'CCP5'; 'CCP5h'; 'CCP3'; 'CCP3h'; 'CCP1'; 'CCP1h'; ...
    'CCPz'; 'CCP2h'; 'CCP2'; 'CCP4h'; 'CCP4'; 'CCP6h'; 'CCP6'; 'TTP8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, TTP8, CCPz , TTP7, nStep);
tenFive.coord(12,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(13,4:18) = {'TP7h'; 'CP5'; 'CP5h'; 'CP3'; 'CP3h'; 'CP1'; 'CP1h'; ...
    'CPz'; 'CP2h'; 'CP2'; 'CP4h'; 'CP4'; 'CP6h'; 'CP6'; 'TP8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, TP8, CPz , TP7, nStep);
tenFive.coord(13,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(14,4:18) = {'TPP7h'; 'CPP5'; 'CPP5h'; 'CPP3'; 'CPP3h'; 'CPP1'; 'CPP1h'; ...
    'CPPz'; 'CPP2h'; 'CPP2'; 'CPP4h'; 'CPP4'; 'CPP6h'; 'CPP6'; 'TPP8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, TPP8, CPPz , TPP7, nStep);
tenFive.coord(14,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(15,4:18) = {'P7h'; 'P5'; 'P5h'; 'P3'; 'P3h'; 'P1'; 'P1h'; ...
    'Pz'; 'P2h'; 'P2'; 'P4h'; 'P4'; 'P6h'; 'P6'; 'P8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, P8, Pz, P7, nStep);
tenFive.coord(15,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(16,4:18) = {'PPO7h'; 'PPO5'; 'PPO5h'; 'PPO3'; 'PPO3h'; 'PPO1'; 'PPO1h'; ...
    'PPOz'; 'PPO2h'; 'PPO2'; 'PPO4h'; 'PPO4'; 'PPO6h'; 'PPO6'; 'PPO8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, PPO8, PPOz , PPO7, nStep);
tenFive.coord(16,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(17,4:18) = {'PO7h'; 'PO5'; 'PO5h'; 'PO3'; 'PO3h'; 'PO1'; 'PO1h'; ...
    'POz'; 'PO2h'; 'PO2'; 'PO4h'; 'PO4'; 'PO6h'; 'PO6'; 'PO8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, PO8, POz , PO7, nStep);
tenFive.coord(17,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

tenFive.names(18,4:18) = {'POO7h'; 'POO5'; 'POO5h'; 'POO3'; 'POO3h'; 'POO1'; 'POO1h'; ...
    'POOz'; 'POO2h'; 'POO2'; 'POO4h'; 'POO4'; 'POO6h'; 'POO6'; 'POO8h'};
[tempPoints, ~, tempLength] = pathonmesh(meshPoints, POO8, POOz , POO7, nStep);
tenFive.coord(18,4:18,:) = pointsrelpos(tempPoints, tempLength, arcPerc);

%% Near points

middlePoint = points2mdpoints(Nz,Iz,Cz);
% idxMatx = [-1 -1 1 1];
% idxMaty = [-1 1 -1 1];



for iPoints = 1 : size(tenFive.coord,1)
	for jPoints = 1 : size(tenFive.coord,2)
		idxMat = false(21 ,21);
		
		if iPoints == 1
			idxMat(iPoints+1,jPoints) = true;
		elseif iPoints == 21
			idxMat(iPoints-1,jPoints) = true;
		else
			idxMat(iPoints-1:2:iPoints+1,jPoints) = true;
		end
		
		if jPoints == 1
			idxMat(iPoints,jPoints+1) = true;
		elseif jPoints == 21
			idxMat(iPoints,jPoints-1) = true;
		else
			idxMat(iPoints,jPoints-1:2:jPoints+1) = true;
		end
		
		
		idxMat = repmat(idxMat,[1,1,3]);
		

		if ~isempty(tenFive.names{iPoints,jPoints})
			centralPoint = squeeze(tenFive.coord(iPoints,jPoints,:))';
			nPoint = size(tenFive.coord(idxMat),1)/3;
			nearPoints = reshape(tenFive.coord(idxMat),[nPoint,3]);
			pointDist = vecnorm(nearPoints - centralPoint,2,2);
			[~, idxPoint] = max(pointDist(:)); 
			referencePoint = nearPoints(idxPoint,:);


			tenFive.neighbors{iPoints,jPoints} = ...
				nearpointonmesh(meshPoints,centralPoint, referencePoint, middlePoint);
		end
	end
end





end

