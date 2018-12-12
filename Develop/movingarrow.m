function movingarrow

f = figure;
a1 = annotation('line',[0 0],[0 0]);
a2 = annotation('line',[0 0],[0 0]);
a3 = annotation('arrow',[0 0],[0 0]);
start = [0 0];

set(f,'WindowButtonDownFcn' ,@prova_sub)
set(f,'WindowButtonUpFcn',@prova3_sub)

function prova_sub(h,~)
start = h.CurrentPoint./[570, 420];
f.WindowButtonMotionFcn = @prova2_sub;
end


function prova3_sub(h,e)
f.WindowButtonMotionFcn = [];
end

function prova2_sub(h,e)
fin =  h.CurrentPoint./[570, 420];
hmed = (start(2)+fin(2))/2;


a1.X = [start(1), start(1)];
a1.Y = [start(2), hmed];
a2.X = [start(1) fin(1)];
a2.Y = [hmed , hmed];
a3.X = [fin(1), fin(1)];
a3.Y = [hmed, fin(2)];

end
end
