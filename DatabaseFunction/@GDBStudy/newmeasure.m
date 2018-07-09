function [measureId, Study] = newmeasure(Study, varargin)
	

	% generate the new id
	measurePostFix = ['M' ,num2str(Study.nSMeasure,'%.3d')];
	measureId = [Study.id , measurePostFix ]; 
	Study.nSMeasure = Study.nSMeasure+1;
	
	posNewMeas = Study.nMeasure + 1;
	
	
	%create the new directory
	pathMeasureAnalysis = fullfile(Study.path,[measurePostFix,'Analysis']);
	mkdir(pathMeasureAnalysis)
	
	Study.Measure(posNewMeas) = GDBMeasure('id',measureId,'path',pathMeasureAnalysis);
	

	if  (nargin == 1)
		Study.Measure(posNewMeas) = GDBMeasure('id',measureId,'path',pathMeasureAnalysis, 'tag',varargin{1});
	else
		Study.Measure(posNewMeas) = GDBMeasure('id',measureId,'path',pathMeasureAnalysis);
	end
	
end

