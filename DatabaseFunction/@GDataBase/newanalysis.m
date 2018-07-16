function [DBAnalysis, DataBase] = newanalysis(DataBase,measureId, varargin)
%Add an ANALYSIS to the database 
%DATABASE.newaanalysis(measureid,'tag',analysis_tag)
%
%
	[Measure, idxMeasure] = DataBase.findid(measureId);
	if ~isempty(Measure)
	% generate the new id
		analysisPostFix = ['A' ,num2str(DataBase.nSAnalysis,'%.6d')];
		analysiId = [DataBase.id , analysisPostFix ]; 
		DataBase.nSAnalysis = DataBase.nSAnalysis+1;

		posNewAn = DataBase.nAnalysis + 1;

		idxArg = find(contains(varargin,'tag','IgnoreCase',true), 1);
		if  ~isempty(idxArg)
			DBAnalysis = GDBAnalysis('id',analysiId,...
									'measureid',measureId,...
									'tag',varargin{idxArg+1});
		else
			DBAnalysis = GDBAnalysis('id',analysiId,...
									'measureid',measureId);
		end

		DataBase.Analysis(posNewAn) = DBAnalysis;

		
		posNewAnalysis = Measure.nAnalysis + 1;
		DataBase.Measure(idxMeasure).analysisId(posNewAnalysis)	= analysiId;
	else
		error('Study not present in the database')
	end	
end

