function varargout = ir_gui(varargin)
% IR_GUI MATLAB code for ir_gui.fig
%      IR_GUI, by itself, creates a new IR_GUI or raises the existing
%      singleton*.
%
%      H = IR_GUI returns the handle to a new IR_GUI or the handle to
%      the existing singleton*.
%
%      IR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IR_GUI.M with the given input arguments.
%
%      IR_GUI('Property','Value',...) creates a new IR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ir_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ir_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ir_gui

% Last Modified by GUIDE v2.5 17-Oct-2013 10:57:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ir_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @ir_gui_OutputFcn, ...
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


% --- Executes just before ir_gui is made visible.
function ir_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ir_gui (see VARARGIN)

% Choose default command line output for ir_gui
handles.output = hObject;

% Update handles structure
global x_offset
global y_offset
global rotation
global move_factor
global rotate_factor
    x_offset = 0;
    y_offset = 0;
    rotation = 0;
    move_factor = 100;
    rotate_factor = 90;
    guidata(hObject, handles);
    axes(handles.axes1);
    
    dest = img_shift(0, 0);
    imshow(dest, 'Parent', handles.axes1)
    

% UIWAIT makes ir_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ir_gui_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x_offset
global y_offset
    x_offset = 0;
    y_offset = 0;
    dest = img_shift(0, 0);
    imshow(dest, 'Parent', handles.axes1)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles) % Move Up
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global move_factor
    set(hObject, 'Enable', 'off');
    negated = move_factor * -1;
    dest = img_shift(0, negated);
    set(hObject, 'Enable', 'on');
    imshow(dest, 'Parent', handles.axes1)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles) % Move Left
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global move_factor
    set(hObject, 'Enable', 'off');
    negated = move_factor * -1;
    dest = img_shift(negated, 0);
    set(hObject, 'Enable', 'on');
    imshow(dest, 'Parent', handles.axes1)

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles) % Move Right
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global move_factor
    set(hObject, 'Enable', 'off');
    dest = img_shift(move_factor, 0);
    set(hObject, 'Enable', 'on');
    imshow(dest, 'Parent', handles.axes1)

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles) % Move Down
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global move_factor
    set(hObject, 'Enable', 'off');
    dest = img_shift(0, move_factor);
    set(hObject, 'Enable', 'on');
    imshow(dest, 'Parent', handles.axes1)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global move_factor    
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    switch str{val};
        case 'Default (100)' % Default Value
            move_factor = 100;
        case '5000'
            move_factor = 5000;
        case '1000'
            move_factor = 1000;
        case '500'
            move_factor = 500;
        case '100'
            move_factor = 100; 
        case '50'
            move_factor = 50;
        case '10'
            move_factor = 10;
        case '5'
            move_factor = 5;
        case '1'
            move_factor = 1;
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global r_factor
    set(hObject, 'Enable', 'off');
    negated = r_factor * -1;
    dest = img_rotate(negated);
    set(hObject, 'Enable', 'on');
    imshow(dest, 'Parent', handles.axes1)
    

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global r_factor
    set(hObject, 'Enable', 'off');
    dest = img_rotate(r_factor);
    set(hObject, 'Enable', 'on');
    imshow(dest, 'Parent', handles.axes1)

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global r_factor    
    str = get(hObject, 'String');
    val = get(hObject, 'Value');
    switch str{val};
        case '90'
            r_factor = 90; % Default Value
        case '45'
            r_factor = 45;
        case '15'
            r_factor = 15;
        case '5'
            r_factor = 5;
        case '1'
            r_factor = 1;
        case '.1'
            r_factor = .1;
        case '.01'
            r_factor = .01;
        case '.001'
            r_factor = .001;
    end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
