function loadimagentISS(GHandle)
% Load a BOXY file data
% Inputs: path of the boxy file and a NIRSMeasure data or []
%
dataType2Save = 'DC';
datatype = {'AC','DC', 'Ph'};
wavelength = [830, 690];
Info = [];
InstrumentType.wavelength = wavelength;
InstrumentType.name = 'Imagent ISS';
InstrumentType.datatype = datatype;

location = GHandle.Temp.location;
fast = GHandle.Temp.fast; % default load all data


pobeFlag = false;
if  isfield(GHandle.CurrentDataSet,'Probe')
    pobeFlag = true;
    Probe = GHandle.CurrentDataSet.Probe;
end

FILE_info = dir(location);
%% Preliminar check on file
FILE = fopen(location); %try to pen the boxy file

if (FILE == -1)    %check if exist
    error('file not found')
    
    
    %% Metadata load
else
    
    date =  datetime(FILE_info.datenum,'ConvertFrom','datenum'); %use the date of the file for the measure data
    AdvanceInfo = [];
    BOXYdata = [];
    
    frewind(FILE); %back to the begin of the file
    while ~feof(FILE)  % till the end of file
        currentline = fgetl(FILE);
        fieldname = erase(currentline(isletter(currentline)),{'FALSE' , 'TRUE'}); %delete all the numbers and special characters from the string
        switch fieldname
            %load information common to all NIRS data
            case 'DetectorChannels'
                AdvanceInfo.DetectorChannel = sscanf(currentline, '%f');
                
            case 'ExternalMUXChannels'
                AdvanceInfo.ExternalMUCChannels = sscanf(currentline, '%f');
                
            case 'AuxiliaryAnalogChannels'
                AdvanceInfo.AuxiliaryAnalogChannels = sscanf(currentline, '%f');
                
            case 'AuxiliaryDigitalChannels'
                AdvanceInfo.AuxiliaryDigitalChannels = sscanf(currentline, '%f');
                
            case 'WaveformCCFFrequencyHz'
                AdvanceInfo.CCFFrequency = sscanf(currentline, '%f');
                
            case 'WaveformsSkipped'
                AdvanceInfo.WaveformsSkipped = sscanf(currentline, '%f');
                
            case 'WaveformsAveraged'
                AdvanceInfo.WaveformsAveraged = sscanf(currentline, '%f');
                
            case 'CyclesAveraged'
                AdvanceInfo.CyclesAveraged = sscanf(currentline, '%f');
                
            case 'AcquisitionsperWaveform'
                AdvanceInfo.AcquisitionsPerWaveform = sscanf(currentline, '%f');
                
            case 'UpdateRateHz'
                updateRate = sscanf(currentline, '%f');
                InstrumentType.UpdateRate = updateRate;
                
            case 'WaveformCalibrationValuesAPPLIED'
                if contains(currentline,'FALSE')
                    InstrumentType.isCalibrated = false;
                end
                if contains(currentline,'TRUE')
                    InstrumentType.isCalibrated = true;
                end
                
            otherwise%load the boxy only info
                if contains(currentline,'FALSE')
                    AdvanceInfo.(fieldname)=false;
                end
                if contains(currentline,'TRUE')
                    AdvanceInfo.(fieldname)=true;
                end
                
        end
    end
    
    frewind(FILE); %back to the begin of the file
    currentline = fgetl(FILE);
    while ~contains(currentline,'#AUX CALIBRATION VALUES') %go to the AUX CAL line
        currentline = fgetl(FILE);
        if currentline == -1  %if reach the endo of file exit
            break
        end
    end
    Auxcalibration = [];
    currentline = fgetl(FILE);
    RowName = split(erase(currentline,'-'),'	');  % save the row name
    RowName = RowName(~cellfun('isempty',RowName));%remove empty cell
    while ~contains(currentline,'#')  %till the next settings
        currentline = fgetl(FILE);
        if contains(currentline,'Term')
            Auxcalibration.Term = sscanf(erase(currentline,'Term'),'%f');
        end
        if contains(currentline,'Factor')
            Auxcalibration.Factor = sscanf(erase(currentline,'Factor'),'%f');
        end
        if currentline == -1
            break
        end
    end
    if ~isempty(Auxcalibration)
        AdvanceInfo.Auxcalibration = struct2table(Auxcalibration,'RowNames',RowName(2:end));
    end
    
    
    frewind(FILE); %back to the begin of the file
    currentline = fgetl(FILE);
    
    AdvanceInfo.Wfcalibration = struct;
    while ~contains(currentline,'#WF CALIBRATION VALUES') %go to the WGF CAL line
        currentline = fgetl(FILE);
        if currentline == -1
            break
        end
    end
    currentline = fgetl(FILE);
    
    
    Wfcal = [];
    DetectorCHName = [];
    while ~contains(currentline,'#')
        currentline = fgetl(FILE);
        RowName = split(erase(currentline,'-'),'	');  % save the row name
        RowName = RowName(2:end);
        RowName = RowName(~cellfun('isempty',RowName));%remove empty cell
        DetectorCHName = [DetectorCHName , RowName'];
        while ~contains(currentline,{'Detector Channel','#'}) %till the next detector or settings
            currentline = fgetl(FILE);
            if contains(currentline,'Term')
                Tempstr = split(erase(currentline,'Term'));
                Tempstr = Tempstr(~cellfun('isempty',Tempstr));
                Term = str2double(Tempstr);
            end
            if contains(currentline,'Factor')
                Tempstr = split(erase(currentline,'Factor'));
                Tempstr = Tempstr(~cellfun('isempty',Tempstr));
                Factor = str2double(Tempstr);
            end
            if currentline == -1
                break
            end
        end
        Wfcal = [Wfcal ,[Term' ; Factor']];
        
    end
    if ~isempty(Wfcal)
        InstrumentType.CalibrationValue = array2table(Wfcal,'VariableNames',DetectorCHName,'RowNames',{'Term','Factor'});
    end
    
    frewind(FILE); %back to the begin of the file
    currentline = fgetl(FILE);
    
    while ~contains(currentline,'#DISTANCE SETTINGS')
        currentline = fgetl(FILE);
        if currentline == -1
            break
        end
    end
    currentline = fgetl(FILE);
    
    DetectorCHName = [];
    Dist = [];
    while ~contains(currentline,'#')
        currentline = fgetl(FILE);
        RowName = split(erase(currentline,'-'),'	');  % save the row name
        RowName = RowName(~cellfun('isempty',RowName));%remove empty cell
        DetectorCHName = [DetectorCHName , RowName'];
        while ~contains(currentline,{'Detector Channel','#'})
            
            currentline = fgetl(FILE);
            if ~(isempty(currentline) || contains(currentline,{'Detector Channel','#'}))
                Tempstr = split(erase(currentline,'Term'));
                Tempstr = Tempstr(~cellfun('isempty',Tempstr));
                Dist = [Dist, str2double(Tempstr)']; %save the dist info
            end
            if currentline == -1
                break
            end
        end
        
        
    end
    if ~isempty(Dist)
        AdvanceInfo.Distance = array2table(Dist,'VariableNames',DetectorCHName);
    end
    
    
    
    
    %% Load raw data
    TrackType.WaveLength = num2cell(wavelength');
    TrackType.Component = datatype;
    nChannel =  length(DetectorCHName)/2;
    TrackType.Channel = num2cell(1:nChannel);
    
    frewind(FILE); %back to the begin of the file
    currentline = fgetl(FILE);     %acquisisce linea per linea fino a che incontra i dati
    while ~contains(currentline,'#DATA BEGINS')
        currentline = fgetl(FILE);
        if currentline == -1
            error('No data in the file')
        end
    end
    
    fgetl(FILE);
    temptimedata = textscan(FILE,'%f %*[^\n]');
    Mdata = table(temptimedata{:},'VariableNames',{'time'});
    
    
    if fast == false
        
        
        frewind(FILE); %back to the begin of the file
        currentline = fgetl(FILE);     %acquisisce linea per linea fino a che incontra i dati
        while ~contains(currentline,'#DATA BEGINS') %return to the start of the data
            currentline = fgetl(FILE);
        end
        ColumnName = split(erase(fgetl(FILE),'-'));  % save the column name
        ColumnName = ColumnName(~cellfun('isempty',ColumnName));%remove empty cell
        fgetl(FILE);
        
        nSamples = length(Mdata.time);
        data = zeros (nSamples, length(ColumnName)); %pre alloc of the data
        checkPoint = floor(linspace(1 , nSamples, 10));
        
        for ii = 1 : nSamples
            currentline = fgetl(FILE);
            data(ii , :) = sscanf(currentline, '%f');
            if any(checkPoint == ii)
                GHandle.Temp.loadingBar.loadingPerc = ii/nSamples;
            end
            
        end
        
        Mdata = array2table(data,'VariableNames',ColumnName(1:end));  %save all
    end
    
    
    Duration = Mdata.time(end) - Mdata.time(1); %duration of the intair measure
    reltime = array2table((Mdata.time - Mdata.time(1)),'VariableNames', {'Time'}); %create the column of relative time
    
    variableIdx = contains(Mdata.Properties.VariableNames,datatype);
    MdataClean = [reltime, Mdata(:,variableIdx)];
    %%sampling frequency check
    AdvanceInfo.fscheck = abs(updateRate-1./mean(diff(reltime{:,1})))./updateRate; %check if the frequency is correct (inserire una deviazione standard?)
    %create new variable name
    channelNames = MdataClean.Properties.VariableNames';
    
    
    if pobeFlag
    nName = length(channelNames);
    newChannelNames = cell(nName,1);
    newChannelNames{1} = 'Time';
    for iName = 2 : nName
        tempChannelNames = '';
        currentChannelName = channelNames{iName};
        switch currentChannelName(2:3)
            case 'AC'
                typeName = 'tAC';
            case 'DC'
                typeName = 'tDC';
            case 'Ph'
                typeName = 'tPh';
        end
        if  mod(iName,2)
            wavelenghName = '_w690';
        else
            wavelenghName = '_w830';
        end
        idxDet = currentChannelName(1)-'A'+1;
        egg = reshape([Probe.channel.pairs]',2, [])';
        idxSrc = egg(egg(:,2)==idxDet,1);
        idxSrc =  idxSrc(ceil(str2double(currentChannelName(4:end))/2));
        srcName = num2str(idxSrc, '_s%.3d');
        %sourceName = num2str(ceil(str2double(currentChannelName(4:end))/2),'%.3d');
        %tempChannelNames = [tempChannelNames, '_s' ,sourceName];
        %detName = num2str(currentChannelName(1)-'A'+1, '%.3d');
        detName = num2str(idxDet, '_d%.3d');
        %tempChannelNames = [tempChannelNames, '_d', detName];
        newChannelNames{iName} = [typeName wavelenghName srcName detName];
    end
    MdataClean.Properties.VariableNames = newChannelNames;
    end
    
    Event = NirsEvent;
    if any(strcmp(Mdata.Properties.VariableNames,'digaux'))
        Event = eventdecoder(Mdata.digaux,InstrumentType.UpdateRate);
    end
    %% Save all in a NIRS measure variable
    
    
    columns2Save = contains(channelNames,dataType2Save);
    columns2Save(1) = true;
    if (size(reltime,1)>500)
        idx = round(linspace(1,size(reltime,1), 500));
        SimplyData = MdataClean(idx,columns2Save);
    else
        SimplyData = MdataClean(:,columns2Save);
    end
    %SimplyData.Time = reltime(idx,:);
    
    GHandle.CurrentDataSet.Measure =  NirsMeasure(...
        'date', date, ...
        'timeLength', Duration, ...
        'Event', Event,...
        'InstrumentType', InstrumentType,...
        'AdvanceInfo', AdvanceInfo,...
        'Info', Info ...
        );
    
    
    GHandle.CurrentDataSet.Analysis = NirsAnalysis(...
        'date', date,...
        'analysis', 'raw',...
        'TrackType', TrackType,...
        'SimplyData', SimplyData...
        );
    
    GHandle.CurrentDataSet.Data = MdataClean;
end
end
