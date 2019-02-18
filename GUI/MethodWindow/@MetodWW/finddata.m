function finddata(obj, analysisId)
DataBase = obj.GHandle.DataBase;

DBAnalysis = DataBase.findid(analysisId);
DBMeasure = DataBase.findid(DBAnalysis.measureId);
DBStudy = DataBase.findid(DBMeasure.studyId);

obj.AnalysisData.Analysis = DBAnalysis.load;
obj.AnalysisData.Data = DBAnalysis.loaddata;
obj.AnalysisData.Measure = DBMeasure.load;
obj.AnalysisData.Study = DBStudy.load;

if ~isempty(DBMeasure.subjectId)
    DBSubject = DataBase.findid(DBMeasure.subjectId);
    obj.AnalysisData.Subject = DBSubject.load;
end
if ~isempty(DBMeasure.probeId)
    DBProbe = DataBase.findid(DBMeasure.probeId);
    obj.AnalysisData.Probe = DBProbe.load;
end
if ~isempty(DBMeasure.atlasId)
    DBAtlas = DataBase.findid(DBMeasure.atlasId);
    obj.AnalysisData.Subject = DBAtlas.load;
end

end

