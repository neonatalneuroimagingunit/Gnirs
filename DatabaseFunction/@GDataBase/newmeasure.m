function [DBMeasure, DataBase] = newmeasure(DataBase, Study, varargin)
	

	% generate the new id
	
	measurePostFix = ['M' ,num2str(DataBase.nSMeasure,'%.6d')];
	measureId = [DataBase.id , measurePostFix ]; 
	DataBase.nSMeasure = DataBase.nSMeasure+1;
	
	posNewMeas = DataBase.nMeasure + 1;
	
	
	%create the new directory
	pathMeasure = fullfile([Study.path,'Measure'],measurePostFix);
	mkdir(pathMeasureAnalysis)
	
	if  (nargin == 3)
		DBMeasure = GDBMeasure('id',measureId,...
								'path',pathMeasure,...
								'studyid',Study.id,...
								'tag',varargin{1});
	else
		DBMeasure = GDBMeasure('id',measureId,...
								'path',pathMeasure,...
								'studyid',Study.id);
	end
	DataBase.Measure(posNewMeas) = DBMeasure;
end

