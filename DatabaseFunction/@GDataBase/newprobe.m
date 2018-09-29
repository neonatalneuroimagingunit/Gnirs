function [DBProbe, DataBase] = newprobe(DataBase,varargin)
	

	% generate the new id
	probePostFix = ['P' ,num2str(DataBase.nSProbe,'%.3d')];
	probeId = [DataBase.id , probePostFix]; 
	DataBase.nSProbe = DataBase.nSProbe+1;
	
	posNewProb = DataBase.nProbe + 1;
	
	pathProbe = fullfile(DataBase.path,'Probe',probePostFix);
	
	idx = find(contains(varargin,'tag','IgnoreCase',true), 1);
	if  ~isempty(idx)
		DBProbe = GDBProbe('id',probeId,...
						'path',pathProbe,...
						'tag',varargin{idx+1});
	else
		DBProbe = GDBProbe('id',probeId,...
							'path',pathProbe);
	end
	
	
	DataBase.Probe(posNewProb) = DBProbe;
	
	
end

