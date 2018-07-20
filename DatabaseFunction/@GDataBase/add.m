function DataBase = add(DataBase, Object2Add, tag)

	objType = class(Object2Add);
		switch objType
			case 'NirsSubject'
				varName = 'Subject';
				
				if Object2Add.template
					template = 'template';
				else
					template = '';
				end
			
				if (nargin > 2)
					[DBObject, DataBase] = DataBase.newsubject(...
														'tag',tag,...
														template);
				else
					if ~isempty(Object2Add.name)
						[DBObject, DataBase] = DataBase.newsubject(...
															'tag',Object2Add.name,...
															template);
					else
						[DBObject, DataBase] = DataBase.newsubject(...
																	template);
					end									
				end
				
				
			case 'NirsAnalysis'
				varName = 'Analysis';
				if (nargin > 2) 
					[DBObject, DataBase] = DataBase.newanalysis(...
											Object2Add.measureId,...
											'tag',tag);
				else
					[DBObject, DataBase] = DataBase.newanalysis(...
											Object2Add.measureId);
				end
				
				
			case 'NirsMeasure'
				varName = 'Measure';
				
				if ~isempty(Object2Add.subjectId)
					subjectId = Object2Add.subjectId;	
				else
					subjectId = '';
				end
				
				if (nargin > 2)  
					[DBObject, DataBase] = DataBase.newmeasure(...
													Object2Add.studyId,...
													'subjectId',subjectId,...
													'tag',tag);

				else
					[DBObject, DataBase] = DataBase.newmeasure(...
													Object2Add.studyId,...
													'subjectId',subjectId);
				end

			case 'NirsStudy'
				varName = 'Study';
				if ~isempty(Object2Add.name)
					[DBObject, DataBase] = DataBase.newstudy('tag',Object2Add.name);
				else
					if (nargin > 2) 
						[DBObject, DataBase] = DataBase.newstudy('tag',tag);
					else
						[DBObject, DataBase] = DataBase.newstudy;
					end
				end
				
				
			case 'NirsProbe'
				varName = 'Probe';
				if ~isempty(Object2Add.name)
					[DBObject, DataBase] = DataBase.newstudy('tag',Object2Add.name);
				else
					if (nargin > 2) 
						[DBObject, DataBase] = DataBase.newstudy('tag',tag);
					else
						[DBObject, DataBase] = DataBase.newstudy;
					end
				end
				
			case 'NirsAtlas'

		

			otherwise
				error('type %s not reconized',objType)
		end
	
	
	Object2Add.id = DBObject.id;
	
	S.(varName) = Object2Add; %#ok
	save(DBObject.path, '-struct', 'S') 
	DataBase.save;
end

