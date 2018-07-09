function Measure = add(Analysis,Measure, varargin)
%need a save database after

	
	% generate the id
	if (nargin == 3)  % the tag
		[DBAnalysis, Measure] = Measure.newanalysis(varargin{1});
	else
		[DBAnalysis, Measure] = Measure.newanalysis;
	end
	
	
	% add file to database
	Analysis.id = DBAnalysis.id;

	save(DBAnalysis.path,'Analysis');
	
end

