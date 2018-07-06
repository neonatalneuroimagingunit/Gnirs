function [probeId, DataBase] = newprobe(DataBase)
	

	% generate the new id
	probeId = [DataBase.id , 'U' ,num2str(DataBase.nSProbe,'%.3d')]; 
	DataBase.nSProbe = DataBase.nSProbe+1;
	
	posNewProb = DataBase.nProbe + 1;
	DataBase.Probe(posNewProb) = GDBProbe(probeId);
	
	DataBase.save;
	
	
	
end

