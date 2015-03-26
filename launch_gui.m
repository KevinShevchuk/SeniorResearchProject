function varargout = launch_gui(varargin)

% LAUNCH_GUI MATLAB code for launch_gui.fig
%      LAUNCH_GUI, by itself, creates a new LAUNCH_GUI or raises the existing
%      singleton*.
%
%      H = LAUNCH_GUI returns the handle to a new LAUNCH_GUI or the handle to
%      the existing singleton*.
%
%      LAUNCH_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAUNCH_GUI.M with the given input arguments.
%
%      LAUNCH_GUI('Property','Value',...) creates a new LAUNCH_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before launch_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to launch_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help launch_gui

% Last Modified by GUIDE v2.5 15-Nov-2013 12:18:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @launch_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @launch_gui_OutputFcn, ...
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


% --- Executes just before launch_gui is made visible.
function launch_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to launch_gui (see VARARGIN)

% Choose default command line output for launch_gui
handles.output = hObject;

%handles.enable_zoom = 1;
axes(handles.axes1);
axes(handles.axes2);
%dragzoom([handles.axes1, handles.axes2]); %Currently Broken.

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes launch_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = launch_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    closereq;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    main;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    quit;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global source_binary
global source_file_name
    source_file_name = uigetfile('*.png');
    set(handles.text6, 'String', source_file_name);
    source_binary = img_process(source_file_name);
    imshow(source_binary, 'Parent', handles.axes2)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gerber
global gerber_file_name
global drill_present
global drill_line_cnt
global dim_x
global dim_y
    gerber_file_name = uigetfile('*.art', 'Select the Gerber file');
    %set(handles.text5, 'String', gerber_file_name);
    if (~isempty(gerber_file_name))
        line_count = gerb_file_io(gerber_file_name);
        [dim_x, dim_y] = gerb_preproc(line_count);
        if (drill_present == 1)
            draw_drl(drill_line_cnt, dim_x, dim_y);
            imshow(gerber, 'Parent', handles.axes1)
        else
            draw_board(line_count, dim_x, dim_y);
            imshow(gerber, 'Parent', handles.axes1)
        end
    end
%     line_count = gerb_file_io(gerber_file_name);
%     [dim_x, dim_y] = gerb_preproc(line_count); % Preprocess the file data.
%     draw_board(line_count, dim_x, dim_y);
%     imshow(gerber, 'Parent', handles.axes1)

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gerber
global render_sf
global gerber_file_name
global drl_file_name
global drill_line_cnt
global gerb_present
global dim_x
global dim_y

    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    switch str{val};
        case '1200'
            render_sf = 1200; % Default Value
        case '2400'
            render_sf = 2400;          
    end
    % Redraw using new scale factor
    if (~isempty(gerber_file_name))
        line_count = gerb_file_io(gerber_file_name);
        [dim_x, dim_y] = gerb_preproc(line_count);
        draw_board(line_count, dim_x, dim_y);
        imshow(gerber, 'Parent', handles.axes1)
    end
    if (~isempty(drl_file_name))
        drill_line_cnt = drl_file_io(drl_file_name);
        drl_preproc(drill_line_cnt, dim_x, dim_y);
        if (gerb_present == 1)
            draw_drl(drill_line_cnt, dim_x, dim_y);
            imshow(gerber, 'Parent', handles.axes1)
        end
    end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gerber
global gerb_present
global drl_file_name
global drill_line_cnt
global dim_x
global dim_y

    drl_file_name = uigetfile('*.drl*', 'Select the Drill file');
    %set(handles.text5, 'String', drl_file_name);
    if (~isempty(drl_file_name))
        drill_line_cnt = drl_file_io(drl_file_name);
        if (gerb_present == 1)
            drl_preproc(drill_line_cnt, dim_x, dim_y);
            draw_drl(drill_line_cnt, dim_x, dim_y);
            imshow(gerber, 'Parent', handles.axes1)
        end
    end
%     line_count = drl_file_io(gerber_file_name);
%     [dim_x, dim_y] = gerb_preproc(line_count); % Preprocess the file data.
%     draw_board(line_count, dim_x, dim_y);
%     imshow(gerber, 'Parent', handles.axes1)
