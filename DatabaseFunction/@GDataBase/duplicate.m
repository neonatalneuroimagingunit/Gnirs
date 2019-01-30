function DataBase = duplicate(DataBase, id)           

DBObject2Duplicate = DataBase.findid(id);
Object2Duplicate = DBObject2Duplicate.load;
objType = class(Object2Duplicate);

switch objType
    case 'NirsSubject'
        Object2Duplicate.tag = ['Copy of ', DBObject2Duplicate.tag];
        DataBase.add(Object2Duplicate,  DBObject2Duplicate.tag);
          
    case 'NirsAnalysis'

        
    case 'NirsMeasure'
        
        
    case 'NirsProbe'
        Object2Duplicate.tag = ['Copy of ', DBObject2Duplicate.tag];
        DataBase = DataBase.add(Object2Duplicate, DBObject2Duplicate.tag);
        if DBObject2Duplicate.forwardFlag
            DataBase.Probe(end).forwardFlag = true;
            copyfile([DBObject2Duplicate.path,'ForwardSim.mat'],[DataBase.Probe(end).path,'ForwardSim.mat']);
        end
         
    case 'NirsAtlas'
        Data2Save = struct;
        if DBObject2Duplicate.flagHead
            Data2Save.HeadAtlas = DBObject2Duplicate.loadhead;
        end
        if DBObject2Duplicate.flagVoxel
            Data2Save.Voxel = DBObject2Duplicate.loadvoxel;
        end
        Object2Duplicate.tag = ['Copy of ', DBObject2Duplicate.tag];
        DataBase = DataBase.add(Object2Duplicate, DBObject2Duplicate.tag, Data2Save);
        
    otherwise
        error('type %s not reconized',objType)
end


DataBase.save;
end

