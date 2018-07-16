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

		pathAnalysis = fullfile([Measure.path,'Analysis'],analysisPostFix);
		
		posNewAn = DataBase.nAnalysis + 1;

		idxArg = find(contains(varargin,'tag','IgnoreCase',true), 1);
		if  ~isempty(idxArg)
			DBAnalysis = GDBAnalysis('id',analysiId,...
									'measureid',measureId,...
									'path',pathAnalysis,...
									'tag',varargin{idxArg+1});
		else
			DBAnalysis = GDBAnalysis('id',analysiId,...
									'path',pathAnalysis,...
									'measureid',measureId);
		end
		
		
		posNewAnalysis = Measure.nAnalysis + 1;
		DataBase.Measure(idxMeasure).analysisId(posNewAnalysis,:)	= analysiId;
		
		DataBase.Analysis(posNewAn) = DBAnalysis;
	else
		error('Study not present in the database')
	end	
end

