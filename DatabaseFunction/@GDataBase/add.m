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
			
				if (nargin < 2)
					if ~isempty(Subject.name)
						[DBObject, DataBase] = DataBase.newsubject(...
															Object2Add.name,...
															template);
					else
						[DBObject, DataBase] = DataBase.newsubject(...
																	template);
					end
				else
					[DBObject, DataBase] = DataBase.newsubject(...
														'tag',tag,...
														template);
				end
				
				
			case 'NirsAnalysis'
				varName = 'Analysis';
				if (nargin < 2) 
					[DBObject, DataBase] = DataBase.newanalysis(...
											Object2Add.measureId,...
											'tag',tag);
				else
					[DBObject, DataBase] = DataBase.newanalysis(...
											Object2Add.measureId);
				end
				
				
			case 'NirsMeasure'
				varName = 'Measure';
				if (nargin < 2)  
					[DBObject, DataBase] = DataBase.newmeasure(...
													Object2Add.StudyId,...
													'tag',tag);
				else
					[DBObject, DataBase] = DataBaseDataBase.newmeasure(...
													Object2Add.StudyId);
				end

				
			case NirsStudy
				varName = 'Study';
				if ~isempty(Study.name)
					[DBObject, DataBase] = DataBase.newstudy('tag',Object2Add.name);
				else
					if (nargin < 2) 
						[DBObject, DataBase] = DataBase.newstudy;
					else
						[DBObject, DataBase] = DataBase.newstudy('tag',tag);
					end
				end

			case 'NirsAtlas'

			case 'NirsProbe'

			otherwise
				error('type %s not reconized',objType)
		end
	
	
	Object2Add.id = DBObject.id;
	save(DBObject.path, varName);

end

