function frecciona(point,vector,style,factor)

vector = factor.*vector;

if strcmp(style,'sversa')
    point = point-vector;
end

x = point(1);
y = point(2);
z = point(3);

u = vector(1);
v = vector(2);
w = vector(3);

quiver3(x,y,z,u,v,w, 'Color', 'g', 'MarkerSize', 10, 'LineWidth', 5);
end