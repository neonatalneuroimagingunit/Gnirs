classdef HasContainer < handle
    % HasContainer - Mixin class for a graphical widget container
    %
    % This class provides common properties and methods that are used by a
    % widget, specifically those that may need to be inherited from
    % multiple related classes. They are defined here instead of
    % uiw.abstract.HasContainer, because we don't want the
    % uiw.abstract.HasContainer constructor to run multiple times for an
    % object that is using multiple inheritance.
    %
    
    %   Copyright 2017-2018 The MathWorks, Inc.
    %
    % Auth/Revision:
    %   MathWorks Consulting
    %   $Author: rjackey $
    %   $Revision: 58 $
    %   $Date: 2018-02-27 14:53:00 -0500 (Tue, 27 Feb 2018) $
    % ---------------------------------------------------------------------
    
    %% Properties
    properties (AbortSet)
        Enable = 'on' %Allow interaction with this widget [(on)|off]
        Padding = 0 %Pixel spacing around the widget (applies to some widgets)
        Spacing = 4 %Pixel spacing between controls (applies to some widgets)
    end %properties
    
    properties (SetAccess=protected, Hidden)
        h struct = struct() %For widgets to store internal graphics objects
        hLayout struct = struct() %For widgets to store internal layout objects
        IsConstructed logical = false %Indicates widget has completed construction, useful for optimal performance to minimize redraws on launch, etc.
    end %properties
    
    
    
    %% Protected methods
    methods (Abstract, Access=protected)
        
        redraw(obj) %Handle state changes that may need UI redraw - subclass must override
        onResized(obj) %Handle changes to widget size - subclass must override
        onEnableChanged(obj,~) %Handle updates to Enable state - subclass must override
        onVisibleChanged(obj,evt) %Handle updates to Visible state - subclass must override
        onStyleChanged(obj,~) %Handle updates to style changes - subclass must override
        onContainerResized(obj) %Triggered on resize of the widget's container - subclass must override
        
    end %methods
    
    
    
    %% Get/Set methods
    methods
        
        % Enable
        function set.Enable(obj,value)
            value = validatestring(value,{'on','off'});
            evt = struct('Property','Enable',...
                'OldValue',obj.Enable,...
                'NewValue',value);
            obj.Enable = value;
            obj.onEnableChanged(evt);
        end
        
        % Padding
        function set.Padding(obj,value)
            validateattributes(value,{'numeric'},{'real','nonnegative','scalar','finite'})
            obj.Padding = value;
            obj.onContainerResized();
        end
        
        % Spacing
        function set.Spacing(obj,value)
            validateattributes(value,{'numeric'},{'real','nonnegative','scalar','finite'})
            obj.Spacing = value;
            obj.onContainerResized();
        end
        
        % IsConstructed
        function value = get.IsConstructed(obj)
            value = isvalid(obj) && obj.IsConstructed;
        end
        
    end % Get/Set methods
    
    
end % classdef
