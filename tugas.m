function varargout = tugas(varargin)
% TUGAS MATLAB code for tugas.fig
%      TUGAS, by itself, creates a new TUGAS or raises the existing
%      singleton*.
%
%      H = TUGAS returns the handle to a new TUGAS or the handle to
%      the existing singleton*.
%
%      TUGAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK v vgin TUGAS.M with the given input arguments.
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

% Last Modified by GUIDE v2.5 19-Feb-2019 08:53:50

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
% AREA UNTUK CITRA DIGITAL DITAMPILKAN
function tugas_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to tugas (see VARARGIN)

    % Choose default command line output for tugas
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);
    axis off;

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

% --- Executes on button press in import.
% FUNGSI IMPORT CITRA DIGITAL UNTUK DITAMPILKAN
function import_Callback(hObject, eventdata, handles)
    % MEMBACA FILE .JPG/.BMP/.PNG UNTUK DITAMPILKAN
    [filename pathname] = uigetfile({'*.jpg;*.bmp;*.png'},'File Selector');
    Img = imread([pathname filename]);
    Img1 = double(Img);
    handles.image = Img;
    handles.image1 = Img1;
    
    % MENAMPILKAN GAMBAR DIGITAL YANG TELAH DIPILIH
    axes(handles.axes1);
    imshow(Img); 
    guidata(hObject, handles);

% --- Executes on button press in grayscale.
% FUNGSI GRAYSCALE CITRA DIGITAL
function grayscale_Callback(hObject, eventdata, handles)
    Img = handles.image;

    % MENGAMBIL NILAI RGB
    redChannel = Img(:, :, 1);
    greenChannel = Img(:, :, 2);
    blueChannel = Img(:, :, 3);

    % MENJUMLAHKAN NILAI RGB
    r = sum(redChannel(:));
    g = sum(greenChannel(:));
    b = sum(blueChannel(:));
    total = sum([r, g, b]);

    % MENDAPATKAN RATIO RGB
    r_ratio = r/total;
    g_ratio = g/total;
    b_ratio = b/total;

    % GRAYSCALING CITRA DIGITAL
    grayImage = r_ratio * redChannel + g_ratio * greenChannel + b_ratio * blueChannel;
    axes(handles.axes1);
    imshow(grayImage);
    guidata(hObject,handles);

% --- Executes on button press in zoomin.
% FUNGSI MEMPERBESAR GAMBAR
function zoomin_Callback(hObject, eventdata, handles)
    Img = handles.image1; % MENGAMBIL IMAGE DARI HANDLES
    
    % MEMBUAT ARRAY KOSONG UNTUK IMAGE YANG AKAN DIPERBESAR
    row = 2*size(Img,1);
    column = 2*size(Img,2);
    newImage = zeros(row, column, 3);
    
    m = 1; n = 1;
    % EKSPLORASI ROW DAN COLUMN IMAGE
    for i = 1:size(Img,1)
        for j = 1:size(Img,2)
            % MENGAMBIL NILAI DARI IMAGE
            newImage(m,n,:) = Img(i,j,:);
            newImage(m,n+1,:) = Img(i,j,:);
            newImage(m+1,n,:) = Img(i,j,:);
            newImage(m+1,n+1,:) = Img(i,j,:);
            n = n+2;
        end
        m = m+2;
        n = 1;    
    end
    
    % MENAMPILKAN HASIL PERBESAR IMAGE
    inimage = uint8(newImage);
    figure, imshow(uint8(inimage));
    handles.image1 = inimage;
    guidata(hObject,handles);

% --- Executes on button press in zoomout.
% FUNGSI MEMPERKECIL GAMBAR
function zoomout_Callback(hObject, eventdata, handles)
    Img = handles.image1; % MENGAMBIL IMAGE DARI HANDLES
    
    % MEMBUAT ARRAY KOSONG UNTUK IMAGE YANG AKAN DIPERKECIL
    newImage = zeros(round(size(Img,1)/2), round(size(Img,2)/2), 3);
    
    % EKSPLORASI ROW DAN COLUMN IMAGE
    m = 1; n = 1;
    for i = 1:size(newImage,1)
        for j = 1:size(newImage,2)
            % MENGAMBIL NILAI DARI IMAGE
            newImage(i,j,:) = Img(m,n,:);
            n = round(n+2);
        end
        m = round(m+2);
        n = 1;
    end
    
    % MENAMPILKAN HASIL PERKECIL IMAGE
    outimage = uint8(newImage);
    figure, imshow(uint8(outimage));
    handles.image1 = outimage;
    guidata(hObject,handles);

% --- Executes on button press in sumbright.
% FUNGSI BRIGHTNESS DENGAN PENJUMLAHAN
function sumbright_Callback(hObject, eventdata, handles)
    Img = handles.image1; % MENDAPATKAN DATA IMAGE DARI DATA HANDLES
    x = get(handles.sumsubs,'String'); % MENGAMBIL NILAI UNTUK DIOPERASIKAN
    y = str2num(x); % MENGUBAH NILAI DARI STRING KE NUM
    
    image = Img(:,:,:) + y; % % MENAMBAHKAN PIXEL DENGAN NILAI YANG DIDAPATKAN
    Img = uint8(image); % MERUBAH BENTUK DOUBLE PADA PIXEL KE BENTUK UINT8 ATAU RGB
    
    axes(handles.axes1); % MENGAKSES AXES
    imshow(Img); % MENAMPILKAN GAMBAR
    handles.image1 = image; % MENYIMPAN DATA IMAGE KE DATA HANDLES
    guidata(hObject, handles); % MENYIMPAN KEDALAM GUI DATA

% --- Executes on button press in subsbright.
% FUNGSI BRIGHTNESS DENGAN PENGURANGAN
function subsbright_Callback(hObject, eventdata, handles)
    Img = handles.image1; % MENDAPATKAN DATA IMAGE DARI DATA HANDLES
    x = get(handles.sumsubs,'String'); % MENGAMBIL NILAI UNTUK DIOPERASIKAN
    y = str2num(x); % MENGUBAH NILAI DARI STRING KE NUM
    
    image = Img(:,:,:) - y; % % MENGURANGI PIXEL DENGAN NILAI YANG DIDAPATKAN
    Img = uint8(image); % MERUBAH BENTUK DOUBLE PADA PIXEL KE BENTUK UINT8 ATAU RGB
    
    axes(handles.axes1); % MENGAKSES AXES
    imshow(Img); % MENAMPILKAN GAMBAR
    handles.image1 = image; % MENYIMPAN DATA IMAGE KE DATA HANDLES
    guidata(hObject, handles); % MENYIMPAN KEDALAM GUI DATA

% --- Executes on button press in timesbright.
% FUNGSI BRIGHTNESS DENGAN PERKALIAN
function timesbright_Callback(hObject, eventdata, handles)
    Img = handles.image1; % MENDAPATKAN DATA IMAGE DARI DATA HANDLES
    x = get(handles.sumsubs,'String'); % MENGAMBIL NILAI UNTUK DIOPERASIKAN
    y = str2num(x); % MENGUBAH NILAI DARI STRING KE NUM
    
    image = Img(:,:,:) * y; % % MENGKALI PIXEL DENGAN NILAI YANG DIDAPATKAN
    Img = uint8(image); % MERUBAH BENTUK DOUBLE PADA PIXEL KE BENTUK UINT8 ATAU RGB
    
    axes(handles.axes1); % MENGAKSES AXES
    imshow(Img); % MENAMPILKAN GAMBAR
    handles.image1 = image; % MENYIMPAN DATA IMAGE KE DATA HANDLES
    guidata(hObject, handles); % MENYIMPAN KEDALAM GUI DATA

% --- Executes on button press in divbright.
% FUNGSI BRIGHTNESS DENGAN PEMBAGIANc
function divbright_Callback(hObject, eventdata, handles)
    Img = handles.image1; % MENDAPATKAN DATA IMAGE DARI DATA HANDLES
    x = get(handles.sumsubs,'String'); % MENGAMBIL NILAI UNTUK DIOPERASIKAN
    y = str2num(x); % MENGUBAH NILAI DARI STRING KE NUM
    
    image = Img(:,:,:) / y; % % MEMBAGI PIXEL DENGAN NILAI YANG DIDAPATKAN
    Img = uint8(image); % MERUBAH BENTUK DOUBLE PADA PIXEL KE BENTUK UINT8 ATAU RGB
    
    axes(handles.axes1); % MENGAKSES AXES
    imshow(Img); % MENAMPILKAN GAMBAR
    handles.image1 = image; % MENYIMPAN DATA IMAGE KE DATA HANDLES
    guidata(hObject, handles); % MENYIMPAN KEDALAM GUI DATA

% TEXT FIELD UNTUK BRIGHTNESS
function sumsubs_Callback(hObject, eventdata, handles)

% LABEL TEXT FIELD UNTUK BRIGHTNESS
% --- Executes during object creation, after setting all properties.
function sumsubs_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in crop.
%FUNGSI CROP IMAGE
function crop_Callback(hObject, eventdata, handles)
    image = handles.image1; % MENDAPATKAN DATA IMAGE DARI DATA HANDLES
    x1 = str2double(get(handles.x1, 'String')); % MENDAPATKAN NILAI DARI TEXT FIELD X1
    x2 = str2double(get(handles.x2, 'String')); % MENDAPATKAN NILAI DARI TEXT FIELD X2
    y1 = str2double(get(handles.y1, 'String')); % MENDAPATKAN NILAI DARI TEXT FIELD Y1
    y2 = str2double(get(handles.y2, 'String')); % MENDAPATKAN NILAI DARI TEXT FIELD Y2
    
    % MELAKUKAN CROP
    newRow = round(y2-y1);
    newColumn = round(x2-x1);
    row = newRow./2;
    column = newColumn./2;
    img = zeros(newRow,newColumn,3);
    figure, imshow(uint8(img));
    img = image(round(row):(newRow+round(row)),round(column):(newColumn+round(column)),:);
    
    %MENAMPILKAN HASIL CROP
    figure, imshow(uint8(img));
    
% --- Executes on button press in clearedit.
%FUNGSI CLEAR IMAGE DARI LAYAR
function clearedit_Callback(hObject, eventdata, handles)
    % MEMBERSIHKAN LAYAR DARI CITRA DIGITAL
    cla(handles.axes1, 'reset');
    axis off;

function x1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function x2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function x2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function y1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function y1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function y2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function y2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
