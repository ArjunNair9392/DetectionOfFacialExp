function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 27-Apr-2014 19:16:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
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
% choose which webcam (winvideo-1) and which  mode (YUY2_176x144)
vid = videoinput('winvideo', 1, 'YUY2_176x144');
% only capture one frame per trigger, we are not recording a video
vid.FramesPerTrigger = 1;
% output would image in RGB color space
vid.ReturnedColorspace = 'rgb';
% tell matlab to start the webcam on user request, not automatically
triggerconfig(vid, 'manual');
% we need this to know the image height and width
vidRes = get(vid, 'VideoResolution');
% image width
imWidth = vidRes(1);
% image height
imHeight = vidRes(2);
% number of bands of our image (should be 3 because it's RGB)
nBands = get(vid, 'NumberOfBands');
% create an empty image container and show it on axPreview
hImage = image(zeros(imHeight, imWidth, nBands), 'parent', handles.axes1);
% begin the webcam preview
preview(vid, hImage);
% prepare for capturing the image preview
start(vid); 
% pause for 3 seconds to give our webcam a "warm-up" time
pause(3); 
% do capture!
trigger(vid);
% stop the preview
stoppreview(vid);
% get the captured image data and save it on capt1 variable
capt1 = getdata(vid);
% now write capt1 into file named captured.png
imwrite(capt1, 'C:\captured.png');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Training
Testing
load('C:\output.mat');
%YY='Happy face detected';
%if(chiA==y)
%    set(handles.text1,'String',  YY);
%end
%YY='Sad face detected';
%if(chiB==y)
%    set(handles.text1,'String',  YY);
%end
%YY='Surprise face detected';
%if(chiC==y)
    set(handles.text1,'String',  YY);
%end



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
%imshow('D:\Documents\PROJECT\LBPcode\h1.tif');
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*','Select the desired image');
captured = strcat(PathName, FileName)
cap = imread(captured);
imwrite(cap, 'C:\captured.png');
imshow(cap, 'Parent', handles.axes1)
