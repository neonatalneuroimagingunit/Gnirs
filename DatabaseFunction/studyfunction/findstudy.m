function StudyList = findstudy(studyID,DataBase)
%FINDSTUDY find a study in the database
%argument the StudyID and the database
%add feature for more complicate search
	
StudyList = DataBase.Study( contains({DataBase.Study.id},studyID));

end

