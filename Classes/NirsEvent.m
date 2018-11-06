classdef NirsEvent
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Dictionary(:,1) cell
        
        type(:,1) int64
        startSamples(:,1) int64
        durationSamples(:,1) int64
        
        samplingFrequency(1,1) double = 1
    end
    properties (Dependent)
        durationTime(:,1) double
        startTime(:,1) double 
    end
    
    
    methods
        function durationTime = get.durationTime(obj)
            durationTime = obj.durationSamples./obj.samplingFrequency;
        end
        function startTime = get.startTime(obj)
            startTime = obj.startTime./obj.samplingFrequency;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

