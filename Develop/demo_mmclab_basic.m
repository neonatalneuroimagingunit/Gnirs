% average optical properties
%mua = 0.02;
%mus = 9;
%g = 0.89;
%n = 1.37;

%% 1
cfg1.nphoton=1e6;
cfg1.node = He.node(:,1:3);
cfg1.face = He.face;
cfg1.elem = He.elem;
cfg1.elemprop=ones(size(cfg1.elem,1),1);
%cfg1.srcpos = [-35.75, -26.22, 25.23];
%cfg1.srcpos = [-14.81, -26.1, 49.23];
cfg1.srcpos = [ -22.2521  -24.2601   44.9243];
distsrpos = vecnorm(Scalp.node - cfg1.srcpos,2,2);
pointmak = distsrpos < 10;
p = fit([Scalp.node(pointmak,1),Scalp.node(pointmak,2)],Scalp.node(pointmak,3),'poly11');
cfg1.srcdir = [-p.p10  -p.p01 1]./norm([-p.p10  -p.p01 1]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reasonable properties (from Fang - MMC website)
% cfg1.prop = [0 0 1 1; ...                 % Air
%              0.019  7.800 0.89 n; ...     % ECT
%              0.004  0.009 0.89 n; ...     % CSF
%              0.020  9.000 0.89 n; ...     % GM
%              0.080 40.900 0.84 n; ...     % WM
%              mua mus g n; ...             % B
%              mua mus g n];                % Cerebellum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fukui 2013 - 800 nm - Human newborn
cfg1.prop = [0 0 1 1; ...                 % Air
             0.017  17.5  0.9 1.3; ...     % ECT
             0.0041 0.32  0.9 1.3; ...     % CSF
             0.048  5.000 0.9 1.3; ...     % GM
             0.037 10     0.9 1.3; ...     % WM
             0.037 10     0.9 1.3; ...             % B
             0.037 10     0.9 1.3];                % Cerebellum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
% test no anisotropy g      
% cfg1.prop = [0 0 1 1; ...                 % Air
%              0.019  7.800 0.01 n; ...     % ECT
%              0.004  0.009 0.01 n; ...     % CSF
%              0.020  9.000 0.01 n; ...     % GM
%              0.080 40.900 0.01 n; ...     % WM
%              mua mus 0.01 n; ...             % B
%              mua mus 0.01 n];                % Cerebellum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
% test no anisotropy g and no scattering      
% cfg1.prop = [0 0 1 1; ...                 % Air
%              0.019  0 0.01 n; ...     % ECT
%              0.004  0 0.01 n; ...     % CSF
%              0.020  0 0.01 n; ...     % GM
%              0.080 0 0.01 n; ...     % WM
%              mua 0 0.01 n; ...             % B
%              mua 0 0.01 n];                % Cerebellum
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cfg1.tstart=0;
cfg1.srctype ='pencil';
cfg1.srcparam1 = 0;
cfg1.srcparam2 = 0; 
cfg1.tend=1e-9;
cfg1.tstep=1e-11;
cfg1.debuglevel='TP';

%% 2
cfg2 = cfg1;
%cfg2.srcpos = [-29, -25.5, 39];
cfg2.srcpos = [-36.2258  -26.0023   14.9006];
distsrpos = vecnorm(Scalp.node - cfg2.srcpos,2,2);
pointmak = distsrpos <10;
p = fit([Scalp.node(pointmak,1),Scalp.node(pointmak,2)],Scalp.node(pointmak,3),'poly11');
cfg2.srcdir = [-p.p10  -p.p01 1]./norm([-p.p10  -p.p01 1]);

%% 1-2
%cross(cfg1.srcpos, cfg2.srcpos);
SD_distance = norm(cfg2.srcpos-cfg1.srcpos);
disp(SD_distance)

%% Run the simulations
tic
fluxx1 = mmclab(cfg1);
t(1) = toc;
tic
fluxx2 = mmclab(cfg2);
t(2) = toc;
fluxx.data = fluxx1.data .* fluxx2.data;

%% Pasticcia le simulations
flux1 = log(abs(sum(fluxx1.data,2))./max(abs(sum(fluxx1.data,2))));
flux2 = log(abs(sum(fluxx2.data,2))./max(abs(sum(fluxx2.data,2))));
sensitivity = log(abs(sum(fluxx.data,2))./ max(abs(sum(fluxx.data,2))));

% get the half sensitivity to see the section in plot
com = centerofmass(He.node, sum(fluxx.data,2)); % center of mass of sensitivity
coff = points2plane(cfg1.srcpos,cfg2.srcpos,com);
n = [coff(1)/coff(4),coff(2)/coff(4),coff(3)/coff(4)] ./ norm([coff(1)/coff(4),coff(2)/coff(4),coff(3)/coff(4)]);
mask1 = dot(He.node(:,1:3)-com, repmat(n,[size(He.node,1) 1]),2) > 0;
half_sensitivity = sensitivity;
half_sensitivity(mask1) = min(half_sensitivity);

% get contours on half sensitivity (wip)
mask2 = abs(dot(He.node(:,1:3)-com, repmat(n,[size(He.node,1) 1]),2)) < 1;
mask3 = half_sensitivity > -1e1;
mask4 = and(mask2,mask3);
%plot3(He.node(mask4,1),He.node(mask4,2),He.node(mask4,3), '.k')
% x = He.node(mask4,1);
% y = He.node(mask4,2);
% z = 
% [n,c] = hist3([x', y']);
% contour(c{1},c{2},n)

%% Plots
scatter3(com(1),com(2),com(3), 25, [0 1 0], 'filled')
PlotHandle = plotsensitivity3d(He,half_sensitivity, 'sensitivityThresHold',-10);


