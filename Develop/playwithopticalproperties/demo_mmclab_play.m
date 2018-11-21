% config
cfg.nphoton = 1e6;
[cfg.node, face, cfg.elem] = meshabox([0 0 0],[60 60 30],6);
cfg.elemprop=ones(size(cfg.elem,1),1);
cfg.srcdir = [0 0 1];
cfg.tstart = 0;
cfg.tend = 5e-9;
cfg.tstep = 5e-9;
cfg.debuglevel = 'TP';

cfg1 = cfg;
cfg2 = cfg;
cfg1.srcpos = [20 30 0];
cfg2.srcpos = [40 30 0];

mua = 0.005;
mus = [0.5 1 2 4 8 16 32 64 128 256];
g = 0.9;
figure
for ii = 1:1:length(mus)
cfg1.prop = [0 0 1 1; mua mus(ii) g 1.37];
cfg2.prop = [0 0 1 1; mua mus(ii) g 1.37];
% run the simulation
flux1 = mmclab(cfg1);
flux2 = mmclab(cfg2);
f1(:,ii) = flux1.data;
f2(:,ii) = flux2.data;
f(:,ii) = f1(:,ii).*f2(:,ii);
subplot(2,5,ii)
plotmesh([cfg.node(:,1:3),log10(abs(f(1:size(cfg.node,1),ii)))],cfg.elem,'y=30','facecolor','interp','linestyle','none')
view([0 1 0]);
title(['\mu_a = ' num2str(mua) ' - \mu_s = ' num2str(mus(ii))])
disp(['mus = ' num2str(ii)])
end
% save data
filename = ['sim_' num2str(mua) '_multimus.mat'];
save(filename, 'cfg1', 'cfg2', 'f1', 'f2', 'f');
% plotting the result

% if you have the SVN version of iso2mesh, use the next line to plot:
% qmeshcut(cfg.elem(:,1:4),cfg.node(:,1:3),log10(abs(flux.data(:))),'y=30','linestyle','none');

plotmesh([cfg.node(:,1:3),log10(abs(flux(1:size(cfg.node,1))))],cfg.elem,'y=30','facecolor','interp','linestyle','none')
view([0 1 0]);
title(['\mu_a = ' num2str(mua) ' - \mu_s = ' num2str(mus)]);
colorbar;
