classdef NirsForward
    properties
        atlasId
        probeId
        date
        
        node
        src
        det
        srcDir
        detDir
        srcFlux
        detFlux
        Settings
        
        note
    end
    
    methods
        function obj = NirsForward(varargin)
            if nargin ~= 0
                if isa(varargin{1},'NirsProbe')
                    obj = varargin{1};
                    varargin(1) = [];
                end
                for i = 1:2:(nargin-1)
                    
                    switch lower(varargin{i})
                        case 'atlasid'
                            obj.atlasId = varargin{i+1};
                            
                        case 'probeid'
                            obj.probeId = varargin{i+1};
                            
                        case 'date'
                            obj.date = varargin{i+1};
                            
                        case 'node'
                            obj.node = varargin{i+1};
                            
                        case 'src'
                            obj.src = varargin{i+1};
                            
                        case 'det'
                            obj.det = varargin{i+1};
                            
                        case 'srcdir'
                            obj.srcDir = varargin{i+1};
                            
                        case 'detdir'
                            obj.detDir = varargin{i+1};
                            
                        case 'srcflux'
                            obj.srcFlux = varargin{i+1};
                            
                        case 'settings'
                            obj.Settings = varargin{i+1};
                            
                        case 'detflux'
                            obj.detFlux = varargin{i+1};
                            
                        case 'note'
                            obj.note = varargin{i+1};
                            
                        otherwise
                            warning('the %s field is not a valid field',varargin{i});
                    end
                end
            end
        end
    end
end

