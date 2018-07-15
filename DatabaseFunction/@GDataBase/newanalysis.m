function [DBAnalysis, DataBase] = newanalysis(DataBase,Measure, varargin)
	

	% generate the new id
	analysisPostFix = ['A' ,num2str(DataBase.nSAnalysis,'%.6d')];
	analysiId = [DataBase.id , analysisPostFix ]; 
	DataBase.nSAnalysis = DataBase.nSAnalysis+1;
	
	posNewAn = DataBase.nAnalysis + 1;

	if  (nargin == 3)
		DBAnalysis = GDBAnalysis('id',analysiId,...
								'measureid',Measure.id,...
								'tag',varargin{1});
	else
		DBAnalysis = GDBAnalysis('id',analysiId,...
								'measureid',Measure.id);
	end
	
	DataBase.Analysis(posNewAn) = DBAnalysis;
	
end

