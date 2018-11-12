classdef GDBProbe
    
    properties (SetAccess = immutable)
        id
    end
    
    properties
        tag(1,:) char
        measureId char
        atlasId char
        path(1,:) char
    end
    
    
    properties (Dependent)
        nMeasure (1,1) int32
    end
    
    methods
        Probe = load(DBProbe)
        DBProbe = modify(DBProbe,NewProbe)
        DBProbe = substitute(DBProbe,Probe)
    end
    methods (Static)
        postFix = id2postfix(id)
    end
    
    methods
        
        function nMeasure = get.nMeasure(obj)
            nMeasure = size(obj.measureId, 1);
        end
        
        function obj = GDBProbe(varargin)
            for iArgIn = 1 : 2 : nargin
                switch lower(varargin{iArgIn})
                    case 'id'
                        obj.id = varargin{iArgIn + 1};
                        
                    case 'tag'
                        obj.tag = varargin{iArgIn + 1};
                        
                    case 'atlasid'
                        obj.atlasId = varargin{iArgIn + 1};
                        
                    case 'path'
                        obj.path = varargin{iArgIn + 1};
                        
                    otherwise
                        warning('%s not a valid GDBProbe field', varargin{iArgIn})
                end
            end
        end
    end
end

