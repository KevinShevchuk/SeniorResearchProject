function varargout = cp_gui(varargin)
% CP_GUI MATLAB code for cp_gui.fig
%      CP_GUI, by itself, creates a new CP_GUI or raises the existing
%      singleton*.
%
%      H = CP_GUI returns the handle to a new CP_GUI or the handle to
%      the existing singleton*.
%
%      CP_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CP_GUI.M with the given input arguments.
%
%      CP_GUI('Property','Value',...) creates a new CP_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cp_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cp_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cp_gui

% Last Modified by GUIDE v2.5 21-Nov-2013 11:38:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cp_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @cp_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before cp_gui is made visible.
function cp_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cp_gui (see VARARGIN)

% Choose default command line output for cp_gui
global gerber
global source_binary
global gerb_clk_count
global src_clk_count
    gerb_clk_count = 0;
    src_clk_count = 0;
    handles.output = hObject;
%     axes(handles.axes1);
%     axes(handles.axes2);
    gerb_handle = imshow(gerber, 'Parent', handles.axes1);
    src_handle = imshow(source_binary, 'Parent', handles.axes2);
    set(gerb_handle, 'ButtonDownFcn', {@axes1_ButtonDownFcn, handles});
    set(src_handle, 'ButtonDownFcn', {@axes2_ButtonDownFcn, handles});
%     child_handles = allchild(handles.axes1);
%     set(child_handles, 'ButtonDownFcn', @axes1_ButtonDownFcn);
%     child_handles = allchild(handles.axes2);
%     set(child_handles, 'ButtonDownFcn', @axes2_ButtonDownFcn);

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes cp_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cp_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    closereq;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    quit;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ps_enable
    ps_enable = 0;
    if (ps_enable == 0)
        set(handles.pushbutton4, 'String', 'ON');
        ps_enable = 1;
    elseif (ps_enable == 1)
        set(handles.pushbutton4, 'String', 'OFF');
        ps_enable = 0;
    else
        error('Error in cp_selection_toggle');
    end 


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gerber_points
global gerb_clk_count

    gerb_clk_count = gerb_clk_count + 1;
    [x, y] = ginput(1);
    gerber_points(1, gerb_clk_count) = round(x);
    gerber_points(2, gerb_clk_count) = round(y);
    [a, b] = center_circle(round(x), round(y));
    gerber_points(3, gerb_clk_count) = round(a);
    gerber_points(4, gerb_clk_count) = round(b);
    set(handles.uitable4, 'Data', gerber_points);
   
    
    %axes_handle = get(hObject, 'Parent');
%     coordinates = get(hObject, 'CurrentPoint');
%     disp(coordinates)
    %set(handles.uitable1, 'Data', gerber_points);


% --- Executes on mouse press over axes background.
function axes2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global src_points
global src_clk_count

    src_clk_count = src_clk_count + 1;
    [x, y] = ginput(1);
    src_points(1, src_clk_count) = round(x);
    src_points(2, src_clk_count) = round(y);
    [a, b] = centroid_blob(round(x), round(y));
    src_points(3, src_clk_count) = round(a);
    src_points(4, src_clk_count) = round(b);
    set(handles.uitable5, 'Data', src_points);
