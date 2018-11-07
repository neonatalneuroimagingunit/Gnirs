classdef NirsEvent
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Dictionary(:,2) cell
        
        type(:,1) int64
        startSample(:,1) int64
        durationSample(:,1) int64
        
        samplingFrequency(1,1) double = 1
    end
    properties (Dependent)
        durationTime(:,1) double
        startTime(:,1) double
    end
    
    
    methods
        function durationTime = get.durationTime(obj)
            durationTime = double(obj.durationSample)/obj.samplingFrequency;
        end
        function startTime = get.startTime(obj)
            startTime = double(obj.startSample)/obj.samplingFrequency;
        end
        
        function obj = NirsEvent(varargin)
            %loadNIRS initialize all possible field of the class NIRSdata
            % To load a data insert first the name of the field and than
            % the value.
            
            if nargin ~= 0
                if isa(varargin{1},'NirsEvent')
                    obj = varargin{1};
                    varargin(1) = [];
                end
                for i = 1:2:(nargin-1)
                    
                    switch lower(varargin{i})
                        case 'dictionary'
                            obj.Dictionary = varargin{i+1};
                            
                        case 'startsample'
                            obj.startSample = varargin{i+1};
                            
                        case 'durationsamples'
                            obj.durationSample = varargin{i+1};
                            
                        case 'type'
                            obj.type = varargin{i+1};
                            
                        case 'samplingfrequency'
                            obj.samplingFrequency = varargin{i+1};
                            
                        otherwise
                            warning('field %s dont exist', varargin{i})
                            
                    end
                end
            end
        end
    end
end

