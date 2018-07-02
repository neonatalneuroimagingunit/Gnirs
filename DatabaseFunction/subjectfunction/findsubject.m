function [SubjectList, index] = findsubject(field, value ,DataBase)

%FINDSUBJECT find a Subject in the database
%argument the Subject field and value, the database

%if the 
if ischar(DataBase)
	DataBase = loadNIRSdb(DataBase);
end
% load all the database study
SubjectList = DataBase.Study;

	for iSubject = 1 : Database.nSubject
		CurretSubject = SubjectList(iSubject);
		for iField = 1 : length(field)

			%search all the field lower case 
			switch lower(field{iField}) 
				% if the value is not present delete the subject from
				% array
				case id
					if ~contains(CurretSubject.id,value{iField})
						SubjectList(iSubject) = []; 
					end

				case name
					if ~contains(CurretSubject.name,value{iField})
						SubjectList(iSubject) = []; 
					end

				case surname
					if ~contains(CurretSubject.surName,value{iField})
						SubjectList(iSubject) = []; 
					end

				case birthday
					if ~(CurretSubject.birthDay == value{iField})
						SubjectList(iSubject) = []; 
					end

				case note
					if ~contains(CurretSubject.note,value{iField})
						SubjectList(iSubject) = []; 
					end
					
				case template
					if ~contains(CurretSubject.template,value{iField})
						SubjectList(iSubject) = []; 
					end

				otherwise
					if isfield(CurretSubject.Info, field{iField})
						if ~(CurretSubject.Info.(field{iField}))
								SubjectList(iSubject) = [];
						end
					else 
						warning('field not found');
					end
			end
		end
	end
	
	if nargout > 1
		index = ismember({DataBase.Study(:).id},{SubjectList(:).id});
	end
 	
	
end


