function data = calibrate(data,CalibValues)
%CALIBRATE Summary of this function goes here
%   Detailed explanation goes here

data = data.*CalibValues(:,1) + CalibValues(:,2);

end

