classdef NirsMethod
    %NIRSANALYSIS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tag (1,:) char
        name(1,:) char
        type(1,:) char
        subType(1,:) char
        
        description(1,:) char
        
        Parameters(:,1) struct
        methodFunction  function_handle
        
        UserParameters(:,1) struct
        plotFunction  function_handle
        
        inputType
        outputType
        
        note(1,:) char
    end
    
    methods
        
    end
    methods
        
        
        function obj = NirsMethod(varargin)
            %initialize all possible field of the class
            %NirsSubject
            % To load a data insert first the name of the field and than
            % the value.
            
            if nargin ~= 0
                if isa(varargin{1},'NirsProbe')
                    obj = varargin{1};
                    varargin(1) = [];
                end
                for i = 1:2:(nargin-1)
                    
                    switch lower(varargin{i})
                        
                        case 'name'
                            obj.name = varargin{i+1};
                            
                        case 'tag'
                            obj.tag = varargin{i+1};
                            
                        case 'type'
                            obj.type = varargin{i+1};
                            
                        case 'subtype'
                            obj.subType = varargin{i+1};
                            
                        case 'description'
                            obj.description = varargin{i+1};
                            
                        case 'parameters'
                            obj.Parameters = varargin{i+1};
                            
                        case 'userparameters'
                            obj.UserParameters = varargin{i+1};
                            
                        case 'methodfunction'
                            obj.methodFunction = varargin{i+1};
                            
                        case 'plotfunction'
                            obj.plotFunction = varargin{i+1};
                            
                        case 'inputtype'
                            obj.inputType =  varargin{i+1};
                            
                        case 'outputtype'
                            obj.outputType =  varargin{i+1};
                            
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

