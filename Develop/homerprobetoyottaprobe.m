function homer2yotta(SD)

% sketch of an import function of HOMER2 SD probes into Yottanirs
% (Jedi level)

% figure
% hold on
% plot3([SD_Daisuke.SrcPos(SD_Daisuke.MeaList(:,1),1)';SD_Daisuke.DetPos(SD_Daisuke.MeaList(:,2),1)'], ...
%       [SD_Daisuke.SrcPos(SD_Daisuke.MeaList(:,1),2)';SD_Daisuke.DetPos(SD_Daisuke.MeaList(:,2),2)'], ...
%       [SD_Daisuke.SrcPos(SD_Daisuke.MeaList(:,1),3)';SD_Daisuke.DetPos(SD_Daisuke.MeaList(:,2),3)'], ...
%     '-k')
% plottone(SD_Daisuke.SrcPos, 20, '.m')
% plottone(SD_Daisuke.DetPos, 20, '.c')
% axis equal
% axis vis3d


nSrc = SD
nDet

for n = 1:1:30
    tempsrc = SD_Daisuke.SrcPos(n,:);
    spam = cat(3,tempsrc(1)*ones(101,101), tempsrc(2)*ones(101,101), tempsrc(3)*ones(101,101));
    dist = vecnorm(spam - GHandle.TempWindow.SelectedAtlas.LandMarks.coord,2,3);
    %[valmin,idxmin] = min(dist(:));
    %[is(n),js(n)] = find(dist==valmin);
    [ds(n),is(n)] = min(dist(:));
end

for n = 1:1:30
    tempsrc = SD_Daisuke.DetPos(n,:);
    spam = cat(3,tempsrc(1)*ones(101,101), tempsrc(2)*ones(101,101), tempsrc(3)*ones(101,101));
    dist = vecnorm(spam - GHandle.TempWindow.SelectedAtlas.LandMarks.coord,2,3);
    %[valmin,idxmin] = min(dist(:));
    %[id(n),jd(n)] = find(dist==valmin);
    [dd(n),id(n)] = min(dist(:));
end

GHandle.TempWindow.Mask.Source(is) = true;
GHandle.TempWindow.Mask.Detector(id) = true;

figure, histogram([dd'; ds'],20)
mean([dd'; ds'])
std([dd'; ds'])