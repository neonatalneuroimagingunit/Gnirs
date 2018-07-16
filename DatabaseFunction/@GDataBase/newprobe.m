function [probeId, DataBase] = newprobe(DataBase,varargin)
	

	% generate the new id
	probeId = [DataBase.id , 'P' ,num2str(DataBase.nSProbe,'%.3d')]; 
	DataBase.nSProbe = DataBase.nSProbe+1;
	
	posNewProb = DataBase.nProbe + 1;
	
	
	idx = find(contains(varargin,'tag','IgnoreCase',true), 1);
	if  ~isempty(idx)
		DataBase.Probe(posNewProb) = GDBProbe('id',probeId,...
											'tag',varargin{idx+1});
	else
		DataBase.Probe(posNewProb) = GDBProbe('id',probeId);
	end
end

