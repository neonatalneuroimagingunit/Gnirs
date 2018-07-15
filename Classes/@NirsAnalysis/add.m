function DataBase = add(Analysis,DataBase, varargin)
%need a save database after

	
	% generate the id
	if (nargin == 3)  % the tag
		[DBAnalysis, DataBase] = DataBase.newanalysis(Analysis.measureId,...
													varargin{1});
	else
		[DBAnalysis, DataBase] = DataBase.newanalysis(Analysis.measureId);
	end
	
	
	% add file to database
	Analysis.id = DBAnalysis.id;

	save(DBAnalysis.path,'Analysis');
	
end

