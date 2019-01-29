%% Distribute equally and display in GUI a number of Label-Value pairs using static text

f = figure;
panelPos = [0.1, 0.1, 0.8, 0.8];
label = {'a'; 'b'; 'c'; 'd'; 'e'; 'a'; 'b'; 'c'; 'd'; 'e'};
value = {'1'; '2'; '3'; '4'; '5'; 'a'; 'b'; 'c'; 'd'; 'e'};

panelBox = uipanel('Parent', f, ...
    'BorderType', 'none', ...
    'Units', 'normalized', ...
    'Position', panelPos);

backgroundColor = [0.9 0.9 0.9];

%% Calculate sizing parameters
N = length(label);
inter = 1/(5*N+1);
intra = 2*inter;

%% Create GUI objects
for ii = 1:1:N
    labelPos = [0.1, intra*ii + 3*inter*(ii-1)+inter, 0.8, inter];
    valuePos = [0.1, intra*ii + 3*inter*(ii-1), 0.8, inter];
    textLabel(ii) = uicontrol('Parent', panelBox, ...
        'Style', 'text', ...
        'Units', 'normalized',...
        'Position', labelPos,...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor', backgroundColor*0.9, ...
        'Visible', 'on', ...
        'String', label{ii});
    textValue(ii) = uicontrol('Parent', panelBox, ...
        'Style', 'text', ...
        'Units', 'normalized',...
        'Position', valuePos,...
        'HorizontalAlignment', 'left', ...
        'BackgroundColor', backgroundColor*1.1, ...
        'Visible', 'on', ...
        'String', value{ii});
end