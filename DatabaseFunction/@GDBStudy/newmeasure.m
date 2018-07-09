function [DBMeasure, Study] = newmeasure(Study, varargin)
	

	% generate the new id
	measurePostFix = ['M' ,num2str(Study.nSMeasure,'%.3d')];
	measureId = [Study.id , measurePostFix ]; 
	Study.nSMeasure = Study.nSMeasure+1;
	
	posNewMeas = Study.nMeasure + 1;
	
	
	%create the new directory
	pathMeasure = fullfile([Study.path,'Measure'],measurePostFix);
	pathMeasureAnalysis = [pathMeasure,'Analysis'];
	mkdir(pathMeasureAnalysis)
	
	Study.Measure(posNewMeas) = GDBMeasure('id',measureId,'path',pathMeasureAnalysis);
	

	if  (nargin == 2)
		DBMeasure = GDBMeasure('id',measureId,'path',pathMeasure, 'tag',varargin{1});
	else
		DBMeasure = GDBMeasure('id',measureId,'path',pathMeasure);
	end
	Study.Measure(posNewMeas) = DBMeasure;
end

