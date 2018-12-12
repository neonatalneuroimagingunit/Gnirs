function com = centerofmass(geometry, weight)

% geometry is Nx3
% weight   is Nx1

com(1) = sum(geometry(:,1).*weight) ./ sum(weight);
com(2) = sum(geometry(:,2).*weight) ./ sum(weight);
com(3) = sum(geometry(:,3).*weight) ./ sum(weight);

end