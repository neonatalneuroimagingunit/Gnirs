function [StudyList, positiveMatch] = findstudy(field, value ,DataBase)
%FINDSTUDY find a study in the database
%argument the StudyID and the database
%add feature for more complicate search
	
	%if the databse was a link load it
	if ischar(DataBase)
		DataBase = loadNIRSdb(DataBase);
	end
	% load all the database study
	if ischar(field)
		field = {field};
	end
	if ischar(value)
		value = {value};
	end


	positiveMatch = boolean(ones(size(DataBase.Study)));

	for iStudy = 1 : DataBase.nStudy
		CurrentStudy = DataBase.Study(iStudy);
		
		for iField = 1 : length(field)
			%search all the field lower case 
			switch lower(field{iField}) 
				% if the value is not present delete the subject from
				% array
				case 'id'
					if isempty(regexp(CurrentStudy.id,value{iField},'once'))
						positiveMatch(iStudy) = 0; 
					end

				case 'name'
					if isempty(regexp(CurrentStudy.name,value{iField},'once'))
						positiveMatch(iStudy) = 0; 
					end

				case 'date'
					if ~(CurrentStudy.date == value{iField})
						positiveMatch(iStudy) = 0; 
					end

				case 'note'
					if isempty(regexp(CurrentStudy.note,value{iField},'once'))
						positiveMatch(iStudy) = 0; 
					end	

			end
		end
	end
	
	StudyList = DataBase.Study(positiveMatch);
	
	


end

