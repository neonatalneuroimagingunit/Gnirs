function tenFive = atlas105maker5(meshPoints,Nz,Iz,RPA,LPA,nStep,nPointAnyDirections,LoadingBarAtlas)

intraPoint = nPointAnyDirections*2;
mainDim = intraPoint+1;

dPerc = 1/(21*(mainDim));

matDimension = 21*(mainDim)-intraPoint;
tenFive.names = cell(matDimension,matDimension);
tenFive.coord = zeros(matDimension,matDimension,3);

arcMainPerc = linspace(0,1,matDimension);

lateralBand = (3 + 2*intraPoint);
nMidPoint = matDimension - 2*lateralBand;
arcSecondaryPerc = linspace(1 - 1/nMidPoint, 0 + 1/nMidPoint, nMidPoint);

Cz = findCz(meshPoints, Iz, Nz, RPA, LPA);
LoadingBarAtlas.loadingPerc = 0.1;
%% find Iz-Cz-Nz line
[pathIzCzNzPoints, ~, pathIzCzNzrelativeLength] = pathonmesh(meshPoints, Iz, Cz , Nz, nStep);
main_BackFront_Points = pointsrelpos(pathIzCzNzPoints, pathIzCzNzrelativeLength, arcMainPerc);
LoadingBarAtlas.loadingPerc = LoadingBarAtlas.loadingPerc + dPerc;

%% find RPA-Cz-LPA line
[pathRPACzLPAPoints, ~, pathRPACzLPArelativeLength] = pathonmesh(meshPoints, RPA, Cz , LPA, nStep);
T9  = pointsrelpos(pathRPACzLPAPoints, pathRPACzLPArelativeLength, 0.9);
T10 = pointsrelpos(pathRPACzLPAPoints, pathRPACzLPArelativeLength, 0.1);
LoadingBarAtlas.loadingPerc = LoadingBarAtlas.loadingPerc + dPerc;

%% find  T10-Cz-T9  line
[pathT10CzT9Points, ~, pathT10CzT9relativeLength] = pathonmesh(meshPoints, T10, Cz , T9, nStep);
main_RightLeft_Points = pointsrelpos(pathT10CzT9Points, pathT10CzT9relativeLength, arcMainPerc);
LoadingBarAtlas.loadingPerc = LoadingBarAtlas.loadingPerc + dPerc;
%% find


for ii = 1 : lateralBand
    LoadingBarAtlas.loadingPerc = LoadingBarAtlas.loadingPerc + dPerc;
    [tempPoints, ~, tempLength] = pathonmesh(meshPoints, main_BackFront_Points(end-ii+1,:), main_RightLeft_Points(end-ii+1,:) , main_BackFront_Points(ii,:), nStep);
    tenFive.coord(:,ii,:) = pointsrelpos(tempPoints, tempLength, arcMainPerc);
end
for ii = 1 : lateralBand
    LoadingBarAtlas.loadingPerc = LoadingBarAtlas.loadingPerc + dPerc;
    [tempPoints, ~, tempLength] = pathonmesh(meshPoints, main_BackFront_Points(end-ii+1,:), main_RightLeft_Points(ii,:) , main_BackFront_Points(ii,:), nStep);
    tenFive.coord(:,end-ii+1,:) = pointsrelpos(tempPoints, tempLength, arcMainPerc);
end
secondaryBackFrontPoints = tenFive.coord(:,lateralBand,:);
secondaryFrontBackPoints = tenFive.coord(:,end - lateralBand + 1,:);
%% Landmarks for arcs

for ii = 1+(3+5*intraPoint/2) : 1 : matDimension-(3 + 5*intraPoint/2) %controlla e' sbagliato
    LoadingBarAtlas.loadingPerc = LoadingBarAtlas.loadingPerc + dPerc;
    [tempPoints, ~, tempLength] = pathonmesh(meshPoints, secondaryFrontBackPoints(ii,:), main_BackFront_Points(end - ii + 1,:) , secondaryBackFrontPoints(ii,:), nStep);
    tenFive.coord(ii, lateralBand+1 : end-lateralBand ,:) = pointsrelpos(tempPoints, tempLength, arcSecondaryPerc);
end

tempNameMatrix = repmat({''},21*(intraPoint+1),21*(intraPoint+1));


tempname = repmat( {'Nz'; 'N1h'; 'N1'; 'AFp9'; 'AF9'; 'AFF9'; 'F9'; 'FFT9'; 'FT9'; 'FTT9'; ...
    'T9'; 'TTP9'; 'TP9'; 'TPP9'; 'P9'; 'PPO9'; 'PO9'; 'POO9'; 'I1'; 'I1h'; 'Iz'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(:,1 : 1 : mainDim) = tempname;

tempname = repmat({'NFpz'; 'NFp1h'; 'NFp1'; 'AFp9h'; 'AF9h'; 'AFF9h'; 'F9h'; 'FFT9h'; 'FT9h'; 'FTT9h'; ...
    'T9h'; 'TTP9h'; 'TP9h'; 'TPP9h'; 'P9h'; 'PPO9h'; 'PO9h'; 'POO9h'; 'O1h'; 'OI1h'; 'OIz'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(:,1+mainDim : 1 : 2*mainDim) = tempname;

tempname = repmat({'Fpz'; 'Fp1h'; 'Fp1'; 'AFp7'; 'AF7'; 'AFF7'; 'F7'; 'FFT7'; 'FT7'; 'FTT7'; ...
    'T7'; 'TTP7'; 'TP7'; 'TPP7'; 'P7'; 'PPO7'; 'PO7'; 'POO7'; 'O1'; 'O1h'; 'Oz'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(:,1+2*mainDim : 1 : 3*mainDim) = tempname;



tempname = repmat({'Nz'; 'N2h'; 'N2'; 'AFp10'; 'AF10'; 'AFF10'; 'F10'; 'FFT10'; 'FT10'; 'FTT10'; ...
    'T10'; 'TTP10'; 'TP10'; 'TPP10'; 'P10'; 'PPO10'; 'PO10'; 'POO10'; 'I2'; 'I2h'; 'Iz'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(:,1+20*mainDim : 1 : 21*mainDim) = tempname;

tempname = repmat({'NFpz'; 'NFp2h'; 'NFp2'; 'AFp10h'; 'AF10h'; 'AFF10h'; 'F10h'; 'FFT10h'; 'FT10h'; 'FTT10h'; ...
    'T10h'; 'TTP10h'; 'TP10h'; 'TPP10h'; 'P10h'; 'PPO10h'; 'PO10h'; 'POO10h'; 'O2h'; 'OI2h'; 'OIz'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(:,1+19*mainDim : 1 : 20*mainDim) = tempname;

tempname = repmat({'Fpz'; 'Fp2h'; 'Fp2'; 'AFp8'; 'AF8'; 'AFF8'; 'F8'; 'FFT8'; 'FT8'; 'FTT8'; ...
    'T8'; 'TTP8'; 'TP8'; 'TPP8'; 'P8'; 'PPO8'; 'PO8'; 'POO8'; 'O2'; 'O2h'; 'Oz'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(:,1+18*mainDim : 1 : 19*mainDim) = tempname;



tempname = repmat({'AFp7h'; 'AFp5'; 'AFp5h'; 'AFp3'; 'AFp3h'; 'AFp1'; 'AFp1h'; ...
    'AFpz'; 'AFp2h'; 'AFp2'; 'AFp4h'; 'AFp4'; 'AFp6h'; 'AFp6'; 'AFp8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+3*mainDim : 1 : 4*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'AF7h'; 'AF5'; 'AF5h'; 'AF3'; 'AF3h'; 'AF1'; 'AF1h'; ...
    'AFz'; 'AF2h'; 'AF2'; 'AF4h'; 'AF4'; 'AF6h'; 'AF6'; 'AF8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+4*mainDim : 1 : 5*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'AFF7h'; 'AFF5'; 'AFF5h'; 'AFF3'; 'AFF3h'; 'AFF1'; 'AFF1h'; ...
    'AFFz'; 'AFF2h'; 'AFF2'; 'AFF4h'; 'AFF4'; 'AFF6h'; 'AFF6'; 'AFF8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+5*mainDim : 1 : 6*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'F7h'; 'F5'; 'F5h'; 'F3'; 'F3h'; 'F1'; 'F1h'; ...
    'Fz'; 'F2h'; 'F2'; 'F4h'; 'F4'; 'F6h'; 'F6'; 'F8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+6*mainDim : 1 : 7*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'FFT7h'; 'FFC5'; 'FFC5h'; 'FFC3'; 'FFC3h'; 'FFC1'; 'FFC1h'; ...
    'FFCz'; 'FFC2h'; 'FFC2'; 'FFC4h'; 'FFC4'; 'FFC6h'; 'FFC6'; 'FFT8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+7*mainDim : 1 : 8*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'FT7h'; 'FC5'; 'FC5h'; 'FC3'; 'FC3h'; 'FC1'; 'FC1h'; ...
    'FCz'; 'FC2h'; 'FC2'; 'FC4h'; 'FC4'; 'FC6h'; 'FC6'; 'FT8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+8*mainDim : 1 : 9*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'FTT7h'; 'FCC5'; 'FCC5h'; 'FCC3'; 'FCC3h'; 'FCC1'; 'FCC1h'; ...
    'FCCz'; 'FCC2h'; 'FCC2'; 'FCC4h'; 'FCC4'; 'FCC6h'; 'FCC6'; 'FTT8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+9*mainDim : 1 : 10*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'T7h'; 'C5'; 'C5h'; 'C3'; 'C3h'; 'C1'; 'C1h'; ...
    'Cz'; 'C2h'; 'C2'; 'C4h'; 'C4'; 'C6h'; 'C6'; 'T8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+10*mainDim : 1 : 11*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'TTP7h'; 'CCP5'; 'CCP5h'; 'CCP3'; 'CCP3h'; 'CCP1'; 'CCP1h'; ...
    'CCPz'; 'CCP2h'; 'CCP2'; 'CCP4h'; 'CCP4'; 'CCP6h'; 'CCP6'; 'TTP8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+11*mainDim : 1 : 12*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'TP7h'; 'CP5'; 'CP5h'; 'CP3'; 'CP3h'; 'CP1'; 'CP1h'; ...
    'CPz'; 'CP2h'; 'CP2'; 'CP4h'; 'CP4'; 'CP6h'; 'CP6'; 'TP8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+12*mainDim : 1 : 13*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'TPP7h'; 'CPP5'; 'CPP5h'; 'CPP3'; 'CPP3h'; 'CPP1'; 'CPP1h'; ...
    'CPPz'; 'CPP2h'; 'CPP2'; 'CPP4h'; 'CPP4'; 'CPP6h'; 'CPP6'; 'TPP8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+13*mainDim : 1 : 14*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'P7h'; 'P5'; 'P5h'; 'P3'; 'P3h'; 'P1'; 'P1h'; ...
    'Pz'; 'P2h'; 'P2'; 'P4h'; 'P4'; 'P6h'; 'P6'; 'P8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+14*mainDim : 1 : 15*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'PPO7h'; 'PPO5'; 'PPO5h'; 'PPO3'; 'PPO3h'; 'PPO1'; 'PPO1h'; ...
    'PPOz'; 'PPO2h'; 'PPO2'; 'PPO4h'; 'PPO4'; 'PPO6h'; 'PPO6'; 'PPO8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+15*mainDim : 1 : 16*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'PO7h'; 'PO5'; 'PO5h'; 'PO3'; 'PO3h'; 'PO1'; 'PO1h'; ...
    'POz'; 'PO2h'; 'PO2'; 'PO4h'; 'PO4'; 'PO6h'; 'PO6'; 'PO8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+16*mainDim : 1 : 17*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

tempname = repmat({'POO7h'; 'POO5'; 'POO5h'; 'POO3'; 'POO3h'; 'POO1'; 'POO1h'; ...
    'POOz'; 'POO2h'; 'POO2'; 'POO4h'; 'POO4'; 'POO6h'; 'POO6'; 'POO8h'}',mainDim,1);
tempname = repmat(tempname(:),1,mainDim);
tempNameMatrix(1+17*mainDim : 1 : 18*mainDim,1+3*mainDim : 1 : 18*mainDim) = tempname';

postFixMatrix = post_fix_matrix_maker(nPointAnyDirections); % left 2 right
postFixMatrixMedial = post_fix_matrix_medial_maker(nPointAnyDirections);

postFixMatrixLeft = repmat(postFixMatrix(:,end:-1:1),[21,10]);
postFixMatrixCentral = repmat(postFixMatrixMedial,[21,1]);
postFixMatrixRight = repmat(postFixMatrix,[21,10]);

tempNameMatrixWhitPostFix = strcat(tempNameMatrix,[postFixMatrixLeft postFixMatrixCentral postFixMatrixRight]);
tempNameMatrixWhitPostFix(cellfun('isempty',tempNameMatrix)) = {''};

tenFive.names = tempNameMatrixWhitPostFix(1+nPointAnyDirections : matDimension + nPointAnyDirections,1+nPointAnyDirections : matDimension + nPointAnyDirections);
end

function postFixMatrix = post_fix_matrix_maker(nPonintAnyDirections)
postFixMatrix = cell(1+2*nPonintAnyDirections, 1+2*nPonintAnyDirections);
postFixMatrix(:) = {''};
for ii = -nPonintAnyDirections : 1 : nPonintAnyDirections
    iIdx = ii+nPonintAnyDirections+1;
    if ii < 0
        tempIStr = ['_R' num2str(-ii)]; %Rostral
    elseif ii > 0
        tempIStr = ['_C' num2str(ii)]; %Caudal
    else
        tempIStr = '';
    end
    for jj = -nPonintAnyDirections : 1 : nPonintAnyDirections
        jIdx = jj+nPonintAnyDirections+1;
        if jj < 0
            tempJStr = ['_M' num2str(-jj)]; %Medial
        elseif jj > 0
            tempJStr = ['_L' num2str(jj)]; %Lateral
        else
            tempJStr = '';
        end
        postFixMatrix{iIdx,jIdx} = [tempJStr tempIStr];
    end
end
end



function postFixMatrix = post_fix_matrix_medial_maker(nPonintAnyDirections)
postFixMatrix = cell(1+2*nPonintAnyDirections, 1+2*nPonintAnyDirections);
postFixMatrix(:) = {''};
for ii = -nPonintAnyDirections : 1 : nPonintAnyDirections
    iIdx = ii+nPonintAnyDirections+1;
    if ii < 0
        tempIStr = ['_R' num2str(-ii)]; %Rostral
    elseif ii > 0
        tempIStr = ['_C' num2str(ii)]; %Caudal
    else
        tempIStr = '';
    end
    for jj = -nPonintAnyDirections : 1 : nPonintAnyDirections
        jIdx = jj+nPonintAnyDirections+1;
        if jj < 0
            tempJStr = ['_l' num2str(-jj)]; %left
        elseif jj > 0
            tempJStr = ['_r' num2str(jj)]; %right
        else
            tempJStr = '';
        end
        postFixMatrix{iIdx,jIdx} = [tempJStr tempIStr];
    end
end
end


