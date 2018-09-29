function data = decalibrate(data,CalibValues)
%DECALIBRATE Summary of this function goes here
%   Detailed explanation goes here
CalibValues(:,2) = -CalibValues(:,2)./CalibValues(:,1);
CalibValues(:,1) = 1./CalibValues(:,1);
data = calibrate(data,CalibValues);
end

