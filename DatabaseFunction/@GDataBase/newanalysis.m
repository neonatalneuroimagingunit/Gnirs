function [analysiId, Measure] = newanalysis(Measure, varargin)
	

	% generate the new id
	analysisPostFix = ['A' ,num2str(Measure.nSAnalysis,'%.3d')];
	analysiId = [Measure.id , analysisPostFix ]; 
	Measure.nSAnalysis = Measure.nSAnalysis+1;
	
	posNewAn = Measure.nAnalysis + 1;
	
	Measure.Analysis(posNewAn) = GDBAnalysis('id',analysiId);
	if  (nargin == 1)
		Measure.Analysis(posNewAn) = GDBAnalysis('id',analysiId, 'tag',varargin{1});
	else
		Measure.Analysis(posNewAn) = GDBAnalysis('id',analysiId);
	end
end

