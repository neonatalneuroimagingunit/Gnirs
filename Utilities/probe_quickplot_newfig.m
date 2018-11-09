nProbes = length(GHandle.DataBase.Probe);
figure
for pp = 1:1:nProbes
    
    aa = zeros(101,101);
    %p = GHandle.DataBase.Probe(pp).load;
    
    nSrc = length(p.source);
    for ss = 1:1:nSrc
        aa(p.source(ss).position2D(1), p.source(ss).position2D(2)) = 1;
    end
    
    nDet = length(p.detector);
    for dd = 1:1:nDet
        aa(p.detector(dd).position2D(1), p.detector(dd).position2D(2)) = 2;
    end
    
    subplot(2,nProbes,pp)
    title(p.name)
    imagesc(aa);
    axis off
    axis equal
    cc = [0.75 0.75 0.75 ; 1 0 0 ; 0 0 1];
    colormap(cc);
    
    subplot(2,nProbes,nProbes + pp)
    title(p.name)
    hold on
    
    for ss = 1:1:nSrc
        plot(p.source(ss).position2D(2),p.source(ss).position2D(1), '.r');  % swap righe e colonne
    end
    for dd = 1:1:nDet
        plot(p.detector(dd).position2D(2),p.detector(dd).position2D(1), '.b');
    end
    axis off
    axis equal
    
end