function rotMat = rotate3dax(angle1, ax)

ax = ax./norm(ax);
u_x = ax(1);
u_y = ax(2);
u_z = ax(3);
rotMat = [cos(angle1)+u_x^2*(1-cos(angle1)),       u_x*u_y*(1-cos(angle1))-u_z*sin(angle1), u_x*u_z*(1-cos(angle1))+u_y*sin(angle1); ...
          u_y*u_x*(1-cos(angle1))+u_z*sin(angle1), cos(angle1)+u_y^2*(1-cos(angle1)),       u_y*u_z*(1-cos(angle1))-u_x*sin(angle1); ...
          u_z*u_x*(1-cos(angle1))-u_y*sin(angle1), u_z*u_y*(1-cos(angle1))+u_x*sin(angle1), cos(angle1)+u_z^2*(1-cos(angle1))];
    