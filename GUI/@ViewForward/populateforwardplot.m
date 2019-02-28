function populateforwardplot(obj)

nSrc = size(obj.Forward.src,1);
nDet = size(obj.Forward.det,1);
obj.ForwardPlot.SrcDirectionArrow = gobjects(nSrc,1);
obj.ForwardPlot.DetDirectionArrow = gobjects(nDet,1);

for iSrc = 1:1:nSrc
    obj.ForwardPlot.SrcDirectionArrow(iSrc) = frecciona2(obj.Forward.src(iSrc,:), obj.Forward.src(iSrc,:)+10*obj.Forward.srcDir(iSrc,:),'Size',[20 0.3],'Color',[0.2 0 0]);
end
for iDet = 1:1:nDet
    obj.ForwardPlot.DetDirectionArrow(iDet) = frecciona2(obj.Forward.det(iDet,:), obj.Forward.det(iDet,:)+10*obj.Forward.detDir(iDet,:),'Size',[20 0.3],'Color',[0 0 0.2]);
end
set(obj.ForwardPlot.SrcDirectionArrow, 'Visible', 'off');
set(obj.ForwardPlot.DetDirectionArrow, 'Visible', 'off');

obj.ForwardPlot.Sensitivity = scatter3(0,0,0, 'Visible', 'off');
end
