f = figure;
hold on

trisurf(Scalp.face,...
    Scalp.node(:,1),Scalp.node(:,2),Scalp.node(:,3),...
    ones(size(Scalp.node(:,3))),...
    'SpecularStrength', 0, ...
    'EdgeColor','none',...
    'FaceColor',[0.7 0.7 0.7],...
    'FaceAlpha',0.3);

trisurf(GM.face,...
GM.node(:,1),GM.node(:,2),GM.node(:,3),...
ones(size(GM.node(:,3))),...
'SpecularStrength', 0, ...
'EdgeColor','none',...
'FaceColor',[0.7 0.2 0],...
'FaceAlpha',0.3);

trisurf(WM.face,...
WM.node(:,1),WM.node(:,2),WM.node(:,3),...
ones(size(WM.node(:,3))),...
'SpecularStrength', 0, ...
'EdgeColor','none',...
'FaceColor',[0 0.2 0.2],...
'FaceAlpha',0.3);

light('Position',[100 0 100]);     % x is left->right, y is back->front
light('Position',[-100 0 100]);

axis equal
axis off
axis vis3d

%plot3(Scalp.node(pointmak,1),Scalp.node(pointmak,2),Scalp.node(pointmak,3),'.g', 'MarkerSize',5)

plot3(cfg1.srcpos(:,1),cfg1.srcpos(:,2),cfg1.srcpos(:,3),'.r', 'MarkerSize',10)
plot3(cfg2.srcpos(:,1),cfg2.srcpos(:,2),cfg2.srcpos(:,3),'.b', 'MarkerSize',10)
frecciona2(cfg1.srcpos,cfg1.srcdir,'Style','down','Size',[20 0.3],'Color',[1 0 0])
frecciona(cfg2.srcpos-20*cfg2.srcdir,cfg2.srcdir,'Style','up','Size',[20 0.3],'Color',[0 0 1])

%print(f,'autoExample', '-dpng', '-r300');

% x = [-50 -50 -25 -25.5];
% y = [-50 10 10 -50];
% z = (p.p10.*x + p.p01.*y + p.p00);
% patch(x', y', z', 'b')
