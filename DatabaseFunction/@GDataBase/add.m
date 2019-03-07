function DataBase = add(DataBase, Object2Add, tag, Data2Save)

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
        
        
        DBStudy = DataBase.findid(DataBase.findid(Object2Add.measureId).studyId);
        Study = DBStudy.load;
        
        if (Study.dateFirstAnalysis > Object2Add.date) ||  isnat(Study.dateFirstAnalysis)
            DBStudy.modify('dateFirstAnalysis', Object2Add.date)
        end
        
        if (Study.dateLastAnalysis < Object2Add.date) ||  isnat(Study.dateLastAnalysis)
            DBStudy.modify('dateLastAnalysis', Object2Add.date)
        end
        
        
        
    case 'NirsMeasure'
        varName = 'Measure';
        
        if ~isempty(Object2Add.subjectId)
            subjectId = Object2Add.subjectId;
        else
            subjectId = '';
        end
        
        if (nargin > 2)
            if ~isempty(Data2Save)
                [DBObject, DataBase] = DataBase.newmeasure(...
                    Object2Add.studyId,...
                    'subjectId',subjectId,...
                    'probeId', Data2Save, ...
                    'tag',tag);
            else
                [DBObject, DataBase] = DataBase.newmeasure(...
                    Object2Add.studyId,...
                    'subjectId',subjectId,...
                    'tag',tag);
            end
        else
            [DBObject, DataBase] = DataBase.newmeasure(...
                Object2Add.studyId,...
                'subjectId',subjectId);
        end
        DBStudy = DataBase.findid(Object2Add.studyId);
        Study = DBStudy.load;
        
        if (Study.dateFirstMeasure > Object2Add.date) ||  isnat(Study.dateFirstMeasure)
            DBStudy.modify('dateFirstMeasure', Object2Add.date)
        end
        
        if (Study.dateLastMeasure < Object2Add.date) ||  isnat(Study.dateLastMeasure)
            DBStudy.modify('dateLastMeasure', Object2Add.date)
        end
        
        
    case 'NirsStudy'
        varName = 'Study';
        if ~isempty(Object2Add.tag)
            [DBObject, DataBase] = DataBase.newstudy('tag',Object2Add.tag);
        else
            if (nargin > 2)
                [DBObject, DataBase] = DataBase.newstudy('tag',tag);
            else
                [DBObject, DataBase] = DataBase.newstudy;
            end
        end
        
        
    case 'NirsProbe'
        varName = 'Probe';
        if ~isempty(Object2Add.tag)
            [DBObject, DataBase] = DataBase.newprobe('tag',Object2Add.tag,'atlasId',Object2Add.atlasId);
        else
            if (nargin > 2)
                [DBObject, DataBase] = DataBase.newprobe('tag',tag,'atlasId',Object2Add.atlasId);
            else
                [DBObject, DataBase] = DataBase.newprobe('atlasId',Object2Add.atlasId);
            end
        end
        
        
    case 'NirsAtlas'
        varName = 'Atlas';
        if ~isempty(Object2Add.tag)
            [DBObject, DataBase] = DataBase.newatlas('tag',Object2Add.tag);
        else
            if (nargin > 2)
                [DBObject, DataBase] = DataBase.newatlas('tag',tag);
            else
                [DBObject, DataBase] = DataBase.newatlas;
            end
        end
        
        if Object2Add.flagVoxel
            DataBase.Atlas(end).flagVoxel = true;
            voxelPath = fullfile(DBObject.path, 'Voxel');
            Voxel = Data2Save.Voxel;
            save(voxelPath, 'Voxel')
        end
        
        if Object2Add.flagHead
            DataBase.Atlas(end).flagHead = true;
            headPath = fullfile(DBObject.path, 'HeadAtlas');
            HeadAtlas = Data2Save.HeadAtlas;
            save(headPath, 'HeadAtlas')
        end
        
    otherwise
        error('type %s not reconized',objType)
end


Object2Add.id = DBObject.id;

S.(varName) = Object2Add;
save(DBObject.path, '-struct', 'S');
DataBase.save;
end

