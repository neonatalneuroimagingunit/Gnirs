function loadimagentISS(GHandle) 
% Load a BOXY file data 
% Inputs: path of the boxy file and a NIRSMeasure data or []
% 
dataType2Save = 'DC';

datatype = {'AC','DC', 'Ph'};
wavelength = [830, 690];


location = GHandle.Temp.location;
fast = GHandle.Temp.fast; % default load all data


FILE_info = dir(location);
%% Preliminar check on file
	FILE = fopen(location); %try to pen the boxy file
	
	if (FILE == -1)    %check if exist
		error('file not found')
		

%% Metadata load	
	else

		date =  datetime(FILE_info.datenum,'ConvertFrom','datenum'); %use the date of the file for the measure data 
		Aquisitioninfo = [];
		BOXYdata = [];
		
		frewind(FILE); %back to the begin of the file
		while ~feof(FILE)  % till the end of file 
			currentline = fgetl(FILE); 
			fieldname = erase(currentline(isletter(currentline)),{'FALSE' , 'TRUE'}); %delete all the numbers and special characters from the string
			switch fieldname
				%load information common to all NIRS data
				case 'DetectorChannels' 
					Aquisitioninfo.DetectorChannel = sscanf(currentline, '%f');
			
				case 'ExterrnalMUXChannels'
				Aquisitioninfo.ExternalMUCChannels = sscanf(currentline, '%f');
			
				case 'AuxiliaryAnalogChannels'
					Aquisitioninfo.AuxiliaryAnalogChannels = sscanf(currentline, '%f');
		
				case 'AuxiliaryDigitalChannels'
					Aquisitioninfo.AuxiliaryDigitalChannels = sscanf(currentline, '%f');
		

				case 'WaveformCCFFrequencyHz'
					Aquisitioninfo.CCFFrequency = sscanf(currentline, '%f');

				case 'WaveformsSkipped'
					Aquisitioninfo.WaveformsSkipped = sscanf(currentline, '%f');

				case 'WaveformsAveraged'
					Aquisitioninfo.WaveformsAveraged = sscanf(currentline, '%f');

				case 'CyclesAveraged'
					Aquisitioninfo.CyclesAveraged = sscanf(currentline, '%f');


				case 'AcquisitionsperWaveform'
					Aquisitioninfo.AcquisitionsPerWaveform = sscanf(currentline, '%f');


				case 'UpdateRateHz'
					Aquisitioninfo.UpdateRate = sscanf(currentline, '%f');

				otherwise%load the boxy only info
					if contains(currentline,'FALSE')  
						BOXYdata.(fieldname)=false;
					end
					if contains(currentline,'TRUE')
						BOXYdata.(fieldname)=true;
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
			CalibrationInfo.Auxcalibration = struct2table(Auxcalibration,'RowNames',RowName(2:end));
		end
		
		
		frewind(FILE); %back to the begin of the file	
		currentline = fgetl(FILE);
		
		CalibrationInfo.Wfcalibration = struct;
		Wfcal = [];
		
		while ~contains(currentline,'#WF CALIBRATION VALUES') %go to the WGF CAL line
			currentline = fgetl(FILE);  
			if currentline == -1
				break
			end
		end
		currentline = fgetl(FILE);
		
		while ~contains(currentline,'#')
			
			DetectorCHName = currentline(1); %the 1 charaqcter of the line contain the Det Name
			currentline = fgetl(FILE);
			RowName = split(erase(currentline,'-'),'	');  % save the row name
			RowName = RowName(2:end);
			RowName = RowName(~cellfun('isempty',RowName));%remove empty cell 
			while ~contains(currentline,{'Detector Channel','#'}) %till the next detector or settings
				currentline = fgetl(FILE);
				if contains(currentline,'Term')
					Tempstr = split(erase(currentline,'Term'));
					Tempstr = Tempstr(~cellfun('isempty',Tempstr));
					Wfcal.Term = str2double(Tempstr);
				end
				if contains(currentline,'Factor')
					Tempstr = split(erase(currentline,'Factor'));
					Tempstr = Tempstr(~cellfun('isempty',Tempstr));
					Wfcal.Factor = str2double(Tempstr);
				end
				if currentline == -1
					break
				end
			end
			if ~isempty(Wfcal)
				CalibrationInfo.Wfcalibration.(DetectorCHName) = struct2table(Wfcal,'RowNames',RowName);
			end
			
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
		
		while ~contains(currentline,'#')
			DetectorCHName = currentline(1);
			currentline = fgetl(FILE);
			RowName = split(erase(currentline,'-'),'	');  % save the row name
			RowName = RowName(~cellfun('isempty',RowName));%remove empty cell 
			while ~contains(currentline,{'Detector Channel','#'})
				currentline = fgetl(FILE);
				if ~(isempty(currentline) || contains(currentline,{'Detector Channel','#'}))
					Tempstr = split(erase(currentline,'Term'));
					Tempstr = Tempstr(~cellfun('isempty',Tempstr));
					Dist = str2double(Tempstr); %save the dist info
				end
				if currentline == -1
					break
				end
			end
			if ~isempty(Dist)
				Distance.(DetectorCHName) = array2table(Dist,'RowNames',RowName);
			end
			
		end
		

		
		
		
%% Load raw data	
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
					GHandle.Temp.loadingBar.Observ1 = floor(10*ii/nSamples);					
				end
				
			end
			
%			data = fscanf(FILE,'%f',[length(ColumnName),Inf]); %parse all row data
			Mdata = array2table(data,'VariableNames',ColumnName(1:end));  %save all
		end
		
		
		Duration = Mdata.time(end) - Mdata.time(1); %duration of the intair measure
		reltime = array2table((Mdata.time - Mdata.time(1)),'VariableNames', {'Time'}); %create the column of relative time 

		variableIdx = contains(Mdata.Properties.VariableNames,datatype);
		Mdata = [reltime, Mdata(:,variableIdx)];
		%%sampling frequency check
		Aquisitioninfo.fscheck = abs(Aquisitioninfo.UpdateRate-1./mean(diff(reltime{:,1})))./Aquisitioninfo.UpdateRate; %check if the frequency is correct (inserire una deviazione standard?)
	
		channel = (size(Mdata,2) - 1) / (length(datatype)*length(wavelength));
%% Save all in a NIRS measure variable
			Info = Aquisitioninfo;
			Info.BOXY = BOXYdata;
			Info.Calibration = CalibrationInfo;
			Info.Distance = Distance;
				
			channelNames = Mdata.Properties.VariableNames;
			columns2Save = contains(channelNames,dataType2Save);			
			if (size(reltime,1)>500)
				idx = round(linspace(1,size(reltime,1), 500));
				SimplyData = Mdata(idx,columns2Save);
			else
				SimplyData = Mdata(:,columns2Save);
			end
			SimplyData.Time = reltime(idx,:);
			
			GHandle.CurrentDataSet.Measure =  NirsMeasure(...
				'date', date, ...
				'timeLength', Duration, ...
				'wavelength', wavelength,...
				'datatype', datatype,...
				'channel',channel,...
				'updaterate', Aquisitioninfo.UpdateRate,...
				'Info', Info ...                                              
				);
		

			GHandle.CurrentDataSet.Analysis = NirsAnalysis(...
				'date', date,...
				'analysis', 'raw',...
				'SimplyData', SimplyData...
				);
			
			GHandle.CurrentDataSet.Data = Mdata;
	end
end	
