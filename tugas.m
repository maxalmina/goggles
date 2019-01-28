function varargout = tugas(varargin)
% TUGAS MATLAB code for tugas.fig
%      TUGAS, by itself, creates a new TUGAS or raises the existing
%      singleton*.
%
%      H = TUGAS returns the handle to a new TUGAS or the handle to
%      the existing singleton*.
%
%      TUGAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUGAS.M with the given input arguments.
%
%      TUGAS('Property','Value',...) creates a new TUGAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tugas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tugas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tugas

% Last Modified by GUIDE v2.5 27-Jan-2019 20:38:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tugas_OpeningFcn, ...
                   'gui_OutputFcn',  @tugas_OutputFcn, ...
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


% --- Executes just before tugas is made visible.
function tugas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tugas (see VARARGIN)

% Choose default command line output for tugas
handles.output = hObject;
set(gca,'Visible','off')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tugas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tugas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[filename pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
Img = imread([pathname filename]);
axes(handles.axes1);
imshow(Img);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
