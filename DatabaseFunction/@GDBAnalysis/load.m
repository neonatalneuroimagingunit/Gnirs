function Analysis = load(DBAnalysis)
	
	temp = load(DBAnalysis.path,'Analysis');
	Analysis = temp.Analysis;
end

