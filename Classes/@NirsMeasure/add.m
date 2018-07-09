function Study = add(Measure,Study, varargin)
%need a save database after

	
	% generate the id
	if (nargin == 3)  % the tag
		[DBMeasure, Study] = Study.newmeasure(varargin{1});
	else
		[DBMeasure, Study] = Study.newmeasure;
	end
	
	
	% add file to database
	Measure.id = DBMeasure.id;

	save(DBMeasure.path,'Measure');
	
end

