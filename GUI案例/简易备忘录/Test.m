function varargout = Test(varargin)
% TEST MATLAB code for Test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Test

% Last Modified by GUIDE v2.5 22-Dec-2016 13:55:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test_OpeningFcn, ...
                   'gui_OutputFcn',  @Test_OutputFcn, ...
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


% --- Executes just before Test is made visible.
function Test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test (see VARARGIN)

% Choose default command line output for Test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.edit1,'string',get(handles.slider1,'value'))


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.edit2,'string',get(handles.slider2,'value'))

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str = get(handles.edit3, 'string');
if isempty(str)
  errordlg('请添加事件内容!!!!!','事件添加错误','error');
  return;
end

str = get(handles.edit4, 'string');
if isempty(str)
  errordlg('时间格式不对，请重新输入!!!','事件添加错误','error');
  return;
end
S = regexp(str, ':', 'split');
hour = str2double(S{1,1});
minute = str2double(S{1,2});
if isnan(hour) || isnan(minute) || ~strcmp(str(3), ':') || length(str)> 5
  errordlg('时间格式不对，请重新输入!!!','事件添加错误','error');
  set(handles.edit4, 'string', '');
  return;
end

if hour < 0 || hour >23 || minute < 0 || minute >59
  errordlg('时间范围不对，请重新输入!!!','事件添加错误','error');
  set(handles.edit4, 'string', '');
  return;
end

% 写一些有趣的提示吧

if hour == 23
  msgbox('这么晚了，要休息了！','晚安！');
end

if hour == 0 || hour == 1
  msgbox('还不睡觉，你在干嘛！','身体要紧！');
end

if hour == 6
  msgbox('真是很勤奋啊！','点赞！');
end

thing = get(handles.edit3, 'string');
time = get(handles.edit4, 'string');
S = regexp(time, ':', 'split');
if str2double(S{1,1}) <10 && length(S{1,1}) == 1
  S{1,1} = ['0' S{1,1}];
end
if str2double(S{1,2}) <10 && length(S{1,2}) == 1
  S{1,2} = ['0' S{1,2}];
end
time = [S{1,1} ':' S{1,2}];
record = {thing,time};
things = get(handles.uitable1, 'data');
if strcmp(things{1,1},'')
  set(handles.uitable1, 'data', record);
else
  record = [things; record];
  set(handles.uitable1, 'data', record);
end


function edit3_KeyPressFcn(hObject, eventdata, handles)


function edit4_KeyPressFcn(hObject, eventdata, handles)


function edit3_ButtonDownFcn(hObject, eventdata, handles)


function figure1_CreateFcn(hObject, eventdata, handles)

function pushbutton2_Callback(hObject, eventdata, handles)


function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(timerfind);
% Hint: delete(hObject) closes the figure
delete(hObject);


function pushbutton3_Callback(hObject, eventdata, handles)
tableData = get(handles.uitable1, 'data');
if isempty(tableData{1})
    return;
end
t = timer('Period', 1, 'TimerFcn', {@timeUpdate, handles.uitable1}, 'BusyMode', 'queue', ...
               'ExecutionMode','fixedRate');
start(t);

function timeUpdate(obj, ~, hUitable1)
if ishandle(hUitable1)
  time = floor(clock);
  hour = time(4);
  minute = time(5);
  seconds = time(6);
  shour = num2str(hour);
  sminute = num2str(minute);
  if hour <10
    shour = ['0' num2str(hour)];
  end
  if minute <10
    sminute = ['0' num2str(minute)];
  end
  records = get(hUitable1, 'data');
  for i = 1:size(records,1)
    if strcmp(records{i,2}, [shour ':' sminute]) && seconds == 0
      load train 
      sound(y,Fs);
      msgbox(records{i,1},'提醒');
      return;
    end
  end
else
  stop(obj);
  delete(obj);
end
