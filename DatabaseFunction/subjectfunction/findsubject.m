function [SubjectList, positiveMatch] = findsubject(field, value ,DataBase)

%FINDSUBJECT find a Subject in the database
%argument the Subject field and value, the database

%if the 
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


positiveMatch = boolean(ones(size(DataBase.Subject)));

	for iSubject = 1 : DataBase.nSubject
		CurretSubject = DataBase.Subject(iSubject);
		for iField = 1 : length(field)

			%search all the field lower case 
			switch lower(field{iField}) 
				% if the value is not present delete the subject from
				% array
				case 'id'
					if ~regexp(CurretSubject.id,value{iField},'once')

						positiveMatch(iSubject) = 0; 
					end

				case 'name'
					if ~regexp(CurretSubject.name,value{iField},'once')

						positiveMatch(iSubject) = 0; 
					end

				case 'surname'
					if ~regexp(CurretSubject.surName,value{iField},'once')

						positiveMatch(iSubject) = 0; 
					end

				case 'birthday'
					if (CurretSubject.birthDay == value{iField})

						positiveMatch(iSubject) = 0; 
					end

				case 'note'
					if ~regexp(CurretSubject.note,value{iField},'once')

						positiveMatch(iSubject) = 0; 
					end
					
				case 'template'
					if ~regexp(CurretSubject.template,value{iField},'once')

						positiveMatch(iSubject) = 0; 
					end

				otherwise
					if isfield(CurretSubject.Info, field{iField})
						if ~(CurretSubject.Info.(field{iField}) == value{iField})
								positiveMatch(iSubject) = 0; 
						end
					else 
						warning('field not found');
					end
			end
		end
	end
	
	SubjectList = DataBase.Subject(positiveMatch);
	
	
end


