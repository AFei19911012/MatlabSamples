function varargout = QRcode(varargin)
% QRCODE MATLAB code for QRcode.fig
%      QRCODE, by itself, creates a new QRCODE or raises the existing
%      singleton*.
%
%      H = QRCODE returns the handle to a new QRCODE or the handle to
%      the existing singleton*.
%
%      QRCODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QRCODE.M with the given input arguments.
%
%      QRCODE('Property','Value',...) creates a new QRCODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before QRcode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to QRcode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help QRcode

% Last Modified by GUIDE v2.5 13-Dec-2016 13:30:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @QRcode_OpeningFcn, ...
                   'gui_OutputFcn',  @QRcode_OutputFcn, ...
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


% --- Executes just before QRcode is made visible.
function QRcode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to QRcode (see VARARGIN)

% Choose default command line output for QRcode
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes QRcode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = QRcode_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global mtx
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Please input (English character) ','Width','Heigth'};
dlg_title = 'Input';
defans = {'Input your text here !','128','128'};
InVlue = inputdlg(prompt,dlg_title,1,defans);
if isempty(InVlue)
    clear global
    return;
end
content = InVlue{1};
width = str2double(InVlue{2});
height = str2double(InVlue{3});
zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing.jar');
c = onCleanup(@()javarmpath(zxingpath));
javaaddpath(zxingpath);
writer = com.google.zxing.MultiFormatWriter();
bitmtx = writer.encode(content, com.google.zxing.BarcodeFormat.QR_CODE,...
                       width, height);
mtx = char(bitmtx);
clear bitmtx writer
mtx(mtx==10) = []; % remove \n
mtx = reshape(mtx(1:2:end), width, height)'; % remove extra space and transpose
mtx(mtx~='X') = 1;
mtx(mtx=='X') = 0;
mtx = double(mtx);
if nargout == 0
    imshow(mtx,'Border','tight');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, PathName]=uigetfile(...
    { '*.png', 'PNG File(*.png)'; ...
      '*.bmp', 'BMP File(*.bmp)'; ...
      '*.gif', 'GIF File(*.gif)'; ...
      '*.jpg', 'JPG File(*.jpg)'; ...
      '*.*', 'All Files(*.*)'}, ...
     'Choose File');
if FileName == 0 || PathName == 0
	return;
end
str = [PathName,FileName];
p = imread(str);    
imshow(str,'Border','tight');
im = rgb2gray(p);

zxingpath = fullfile(fileparts(mfilename('fullpath')), 'zxing.jar');
javaaddpath(zxingpath);

import com.google.zxing.*

im = im2java(im);
width = im.getWidth(); % if getWidth is not called, getBufferedImage will fail.
height = im.getHeight();

source = client.j2se.BufferedImageLuminanceSource(im.getBufferedImage());
binarizer = common.HybridBinarizer(source);
bitmap = BinaryBitmap(binarizer);
reader = MultiFormatReader();
ret = char(reader.decode(bitmap));
set(handles.edit1,'string',ret);


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global mtx
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uiputfile(...
    { '*.png', 'PNG File(*.png)'; ...
      '*.bmp', 'BMP File(*.bmp)'; ...
      '*.gif', 'GIF File(*.gif)'; ...
      '*.jpg', 'JPG File(*.jpg)'; ...
      '*.*', 'All Files(*.*)'}, ...
     'Save picture as');
%if user cancels save command, nothing happens
if isequal(filename,0) || isequal(pathname,0)
    return
end
%create a new figure
newFig = figure;
set(gcf,'visible','off');
imshow(mtx,'Border','tight');
% newAxes = copyobj(handles.axes2,newFig);  
% set(newAxes,'Units','default','Position','default','Color','default');
saveas(newFig,fullfile(pathname, filename)) 
%closes the figure
close(newFig)
clear global
