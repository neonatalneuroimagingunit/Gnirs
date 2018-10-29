function loadpreferences(GHandle)

FILE = fopen(GHandle.Preference.Path.preferenceTxt);

if (FILE == -1)    %check if exist
    error('file not found')
else
    
    fopen(FILE);
    frewind(FILE); %back to the begin of the file
    while ~feof(FILE)
        fieldName = fgetl(FILE);
        switch fieldName
            %load information common to all NIRS data
            case '#DATABASEPATH' % string
                fieldValue = fgetl(FILE);
                GHandle.Preference.Path.databasePath = fieldValue;
            case '#DEFAULTFONTNAME' % string
                fieldValue = fgetl(FILE);
                GHandle.Preference.Path.defaultFontName = fieldValue;
            case '#THEME'
                fieldValue = fgetl(FILE);
                GHandle.Preference.Theme.Name = fieldValue;
                
            case '#CLASSICTHEME_BACKGROUNDCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicBackgroundColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_FOREGROUNDCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicForegroundColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_HIGHLIGHTCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicHighlightColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_PANELCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicPanelColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_AXESBACKGROUNDCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicAxesBackgroundColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_WHITEMATTERCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicWhiteMatterColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_GREYMATTERCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicGreyMatterColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_SCALPCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicScalpColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_LANDMARKCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicLandmarkColor = sscanf(fieldValue, '%f')';
            case '#CLASSICTHEME_LANDMARKTEXTCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                classicLandmarkTextColor = sscanf(fieldValue, '%f')';
                
            case '#DARKTHEME_BACKGROUNDCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkBackgroundColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_FOREGROUNDCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkForegroundColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_HIGHLIGHTCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkHighlightColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_PANELCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkPanelColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_AXESBACKGROUNDCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkAxesBackgroundColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_WHITEMATTERCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkWhiteMatterColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_GREYMATTERCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkGreyMatterColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_SCALPCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkScalpColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_LANDMARKCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkLandmarkColor = sscanf(fieldValue, '%f')';
            case '#DARKTHEME_LANDMARKTEXTCOLOR' % three elements row array
                fieldValue = fgetl(FILE);
                darkLandmarkTextColor = sscanf(fieldValue, '%f')';
                
            case ''
                 
            otherwise
                warning(['Invalid theme field: ' fieldName]);
                
        end
        
    end
    
    fclose(FILE);
end

switch GHandle.Preference.Theme.Name
    case 'classic'
        GHandle.Preference.Theme.backgroundColor = classicBackgroundColor;
        GHandle.Preference.Theme.foregroundColor = classicForegroundColor;
        GHandle.Preference.Theme.highlightColor =  classicHighlightColor;
        GHandle.Preference.Theme.panelColor = classicPanelColor;
        GHandle.Preference.Theme.axesBackgroundColor = classicAxesBackgroundColor;
        GHandle.Preference.Theme.whiteMatterColor = classicWhiteMatterColor;
        GHandle.Preference.Theme.greyMatterColor = classicGreyMatterColor;
        GHandle.Preference.Theme.scalpColor = classicScalpColor;
        GHandle.Preference.Theme.landmarkColor = classicLandmarkColor;
        GHandle.Preference.Theme.landmarkTextColor = classicLandmarkTextColor;
    case 'dark'
        GHandle.Preference.Theme.backgroundColor = darkBackgroundColor;
        GHandle.Preference.Theme.foregroundColor = darkForegroundColor;
        GHandle.Preference.Theme.highlightColor =  darkHighlightColor;
        GHandle.Preference.Theme.panelColor = darkPanelColor;
        GHandle.Preference.Theme.axesBackgroundColor = darkAxesBackgroundColor;
        GHandle.Preference.Theme.whiteMatterColor = darkWhiteMatterColor;
        GHandle.Preference.Theme.greyMatterColor = darkGreyMatterColor;
        GHandle.Preference.Theme.scalpColor = darkScalpColor;
        GHandle.Preference.Theme.landmarkColor = darkLandmarkColor;
        GHandle.Preference.Theme.landmarkTextColor = darkLandmarkTextColor;
    otherwise
        warning('Invalid theme: theme not found - Loading default');
        GHandle.Preference.Theme.backgroundColor = get(groot,'defaultFigureColor');
        GHandle.Preference.Theme.foregroundColor = get(groot,'defaultuiControlForegroundColor');
        GHandle.Preference.Theme.highlightColor =  get(groot,'defaultuiPanelHighlightColor');
        GHandle.Preference.Theme.panelColor = get(groot,'defaultuiPanelBackgroundColor');
        GHandle.Preference.Theme.axesBackgroundColor = get(groot,'defaultAxesColor');
        GHandle.Preference.Theme.whiteMatterColor = [1 1 1];
        GHandle.Preference.Theme.greyMatterColor = [0.65 0.65 0.65];
        GHandle.Preference.Theme.scalpColor = [225 229 204]/255;
        GHandle.Preference.Theme.landmarkColor = [0 1 0]; % if you mess up with themes you deserve this eye-crushing green color for landmarks, you fool
        GHandle.Preference.Theme.landmarkTextColor = [0 1 0];
end