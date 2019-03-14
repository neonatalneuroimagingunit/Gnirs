function generatewindow(obj)
obj.MainFigure = figure(...
    'Position', obj.GHandle.Preference.Figure.sizeLarge, ...
    'Units','pixels',...
    'Visible', 'off', ...
    'Resize', 'on',...
    'Name', 'Viewer', ...
    'Numbertitle', 'off', ...
    'Toolbar', 'none', ...
    'Menubar', 'none', ...
    'CloseRequestFcn',  @(h,e)close_request(h,e,obj),...
    'DoubleBuffer', 'on', ...
    'DockControls', 'off', ...
    'Renderer', 'OpenGL');

obj.MainFigure.addprop('CurrentArrow');

obj.TreePanel = uipanel('Parent',obj.MainFigure,...
    'Units','normalized','Position',[0 0 0.2 1]);
obj.MethodPanel = uipanel('Parent',obj.MainFigure,...
    'Units','normalized','Position',[0.21 0 0.59 1]);
obj.InfoSetPanel = uipanel('Parent',obj.MainFigure,...
    'Units','normalized','Position',[0.81 0 0.2 1]);

obj.InfoSetPanelUp = uipanel('Parent',obj.InfoSetPanel,...
    'Units','normalized','Position',[0 0.5 1 0.5]);
obj.InfoSetPanelDown = uipanel('Parent',obj.InfoSetPanel,...
    'Units','normalized','Position',[0 0.1 1 0.4]);
obj.InfoSetAxes = axes('Parent',obj.InfoSetPanelDown,...
    'Units','normalized','Position',[0.1 0.1 0.8 0.8]);


obj.Tree = MethodTree([ 0 0.1 1 0.9 ],obj.TreePanel,obj.MethodList);
obj.Tree.Root.MouseClickedCallback = @(h,e)add_method(h,e,obj);

obj.ResizeButton1 = annotation(obj.MainFigure,'textbox','Units','normalized','Position',[0.2 0 0.01 1],'ButtonDownFcn' ,@(h,e)resize_1(h,e,obj));
obj.ResizeButton2 = annotation(obj.MainFigure,'textbox','Units','normalized','Position',[0.8 0 0.01 1],'ButtonDownFcn' ,@(h,e)resize_2(h,e,obj));

obj.AddOutputButton = uicontrol('Callback',@(h,e)add_output(h,e,obj),...
    'Style','pushbutton',...
    'Parent',obj.TreePanel,...
    'Units','normalized',...
    'Position',[0 0 1 0.1],...
    'String','Add Output');

obj.EvaluateMethodButton = uicontrol('Callback',@(h,e)obj.evaluatemethod(h,e),...
    'Style','pushbutton',...
    'Parent',obj.InfoSetPanel,...
    'Units','normalized',...
    'Position',[0 0 1 0.1],...
    'String','Evaluate');


UserParameters.name = 'Input';
UserParameters.field = '';
UserParameters.string = '';
UserParameters.style = 'text';
InputMethod = NirsMethod('tag', 'Input', 'name', 'Input', 'UserParameters', UserParameters);
obj.MethodBoxList = MethodBox([0.4 0.8 0.16 0.08],obj,InputMethod); %sistemare inputmethod
obj.MethodBoxList.ButtonInput.Visible = 'off';
obj.MainFigure.Visible = 'on';
end


function add_output(~, ~, obj)
UserParameters.name = 'Output';
UserParameters.field = '';
UserParameters.string = '';
UserParameters.style = 'text';
OutputMethod = NirsMethod('tag', 'Output', 'name', 'Output','UserParameters', UserParameters);
TempMethodBox = MethodBox([rand-0.08 0 0.16 0.08],obj,OutputMethod);
obj.MethodBoxList = [obj.MethodBoxList; TempMethodBox];
TempMethodBox.ButtonOutput.Visible = 'off';
end

function add_method(~, Event, obj)
if ~isempty(Event.Nodes) % click on a node
    switch Event.SelectionType
        case 'normal' %displaymethod
        case 'open'
            methodIdx = strcmp({obj.MethodList.tag}, Event.Nodes.Value);
            method2Add = obj.MethodList(methodIdx);
            if ~isempty(method2Add)
                obj.MethodBoxList = [obj.MethodBoxList; MethodBox([rand-0.08 rand-0.04 0.16 0.08], obj, method2Add)];
            end
        case 'alt' %dxstudy
    end
end
end

function resize_1(~, ~, obj)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing1(h,e,obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing1(h,~,obj)
relXPos = h.CurrentPoint(1)./h.Position(3);
obj.ResizeButton1.Position(1) = max(relXPos - 0.005,0);
obj.TreePanel.Position(3) = obj.ResizeButton1.Position(1);
obj.MethodPanel.Position(1) = obj.ResizeButton1.Position(1) + 0.01;
obj.MethodPanel.Position(3) = obj.ResizeButton2.Position(1) - obj.MethodPanel.Position(1);
end

function resize_2(~,~, obj)
obj.MainFigure.WindowButtonMotionFcn = @(h,e)panel_resizing2(h,e,obj);
obj.MainFigure.WindowButtonUpFcn = @(h,e)stop_resizing(h,e);
end
function panel_resizing2(h,~,obj)
relXPos = h.CurrentPoint(1)./h.Position(3);
obj.InfoSetPanel.Position(1) = min(relXPos + 0.005,1);
obj.InfoSetPanel.Position(3) = 1 - obj.InfoSetPanel.Position(1);
obj.ResizeButton2.Position(1) = obj.InfoSetPanel.Position(1) - 0.01;
obj.MethodPanel.Position(3) = obj.ResizeButton2.Position(1) - obj.MethodPanel.Position(1);
end

function stop_resizing(h,~)
h.WindowButtonMotionFcn = [];
h.WindowButtonUpFcn = [];
end

function close_request(Handle, ~, obj)
delete(Handle);
obj.GHandle.MethodWindow = [];
end

