function varargout = DataExtract(varargin)
% DATAEXTRACT MATLAB code for DataExtract.fig
%      DATAEXTRACT, by itself, creates a new DATAEXTRACT or raises the existing
%      singleton*.
%
%      H = DATAEXTRACT returns the handle to a new DATAEXTRACT or the handle to
%      the existing singleton*.
%
%      DATAEXTRACT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAEXTRACT.M with the given input arguments.
%
%      DATAEXTRACT('Property','Value',...) creates a new DATAEXTRACT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DataExtract_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DataExtract_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DataExtract

% Last Modified by GUIDE v2.5 30-Aug-2017 09:01:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DataExtract_OpeningFcn, ...
                   'gui_OutputFcn',  @DataExtract_OutputFcn, ...
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


% --- Executes just before DataExtract is made visible.
function DataExtract_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DataExtract (see VARARGIN)

% Choose default command line output for DataExtract
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DataExtract wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DataExtract_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)
axes(handles.axes1)
cla reset
axis off
set(handles.uitable1, 'data', []);

set(handles.text5, 'string', 'Load a picture !!!');
[FileName, PathName] = uigetfile({'*.bmp'}, 'Load a picture');
if length(PathName) < 3
    msgbox('Failed to load a picture !!!');
    return;
end
FilePath = [PathName, FileName];
Img = imread(FilePath);
axes(handles.axes1);
imshow(Img, 'Border', 'tight');

set(handles.text5, 'string', 'Input the values in EditBoxs; Press left button on the axis; Press Enter to continue !!!');
pause();

set(handles.text5, 'string', 'Locate the start point !!!');
currPt = ginput(1);
x0 = currPt(1, 1);
y0 = currPt(1, 2);
line(x0, y0, 'marker', '.', 'color', 'r', 'markersize', 20);

set(handles.text5, 'string', 'Locate the x-end point !!!');
currPt = ginput(1);
xend = currPt(1, 1);
y = currPt(1, 2);
line(xend, y, 'marker', '.', 'color', 'r', 'markersize', 20);
line([x0, xend], [y0, y], 'color', 'r');

set(handles.text5, 'string', 'Locate the y-end point !!!');
currPt = ginput(1);
x = currPt(1, 1);
yend = currPt(1, 2);
line(x, yend, 'marker', '.', 'color', 'r', 'markersize', 20);
line([x0, x], [y0, yend], 'color', 'r');

set(handles.text5, 'string', 'Now you can locate the point, press RightButton to locate the last point !!!');
tableData = cell(0);
con = 1;
i = 1;
xmin = str2double(get(handles.edit1, 'string'));
xmax = str2double(get(handles.edit2, 'string'));
ymin = str2double(get(handles.edit3, 'string'));
ymax = str2double(get(handles.edit4, 'string'));
scale1 = get(handles.radiobutton1, 'value');
scale2 = get(handles.radiobutton3, 'value');
while con == 1    
    [x, y, con] = ginput(1);
    line(x, y, 'marker', '.', 'color', 'r', 'markersize', 20);
    if scale1 == 1
        xx = (xmax - xmin)*(x - x0)/(xend - x0) + xmin;
    else
        xx = 10^((log10(xmax) - log10(xmin))*(x - x0)/(xend - x0) + log10(xmin));
    end
    if scale2 == 1
        yy = (ymax - ymin)*(y - y0)/(yend - y0) + ymin;
    else
        yy = 10^((log10(ymax) - log10(ymin))*(y - y0)/(yend - y0) + log10(ymin));
    end
    tableData{i, 1} = i;
    tableData{i, 2} = xx;
    tableData{i, 3} = yy;
    set(handles.uitable1, 'data', tableData);
    i = i + 1;
end

function pushbutton2_Callback(hObject, eventdata, handles)
[FileName, PathName] = uiputfile('*.txt', 'save file name');
tableData = get(handles.uitable1, 'data');
tableData = cell2mat(tableData);
if ~isempty(tableData)
    dlmwrite([PathName, FileName], tableData(:, 2:end), 'delimiter', '\t', 'precision', '%8.4f');
end

function pushbutton3_Callback(hObject, eventdata, handles)
close(gcf);

function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(hObject, eventdata, handles)


function edit2_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)


function edit3_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)


function edit4_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
