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

% Last Modified by GUIDE v2.5 19-Mar-2019 11:58:51

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

% FUNGSI CROP IMAGE
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
% FUNGSI CLEAR IMAGE DARI LAYAR
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

% FUNGSI MEMUNCULKAN HISTOGRAM
function histogram_Callback(hObject, eventdata, handles)
    % MENDAPATKAN IMAGE DARI DATA HANDLES
    image = handles.image
    % PREALOCATE
    histRed = zeros(1,256);
    histGreen = zeros(1,256);
    histBlue = zeros(1,256);
    
    % MENGHITUNG SEMUA FREKUENSI RGB PADA IMAGE
    for i =1:size(image,1)
        for j = 1:size(image,2)
            p=image(i,j);
            x=image(i,j,1); % MENGAMBIL PIXEL PADA RED
            y=image(i,j,2); % MENGAMBIL PIXEL PADA GREEN
            z=image(i,j,3); % MENGAMBIL PIXEL PADA BLUE
            histRed(x+1)=histRed(x+1)+1; % MENAMBAH FREKUENSI PADA RED
            histGreen(y+1)=histGreen(y+1)+1; % MENAMBAH FREKUENSI PADA GREEN
            histBlue(z+1)=histBlue(z+1)+1; % MENAMBAH FREKUENSI PADA BLUE
        end
    end
    
    % MENAMPILKAN HISTOGRAM RGB
    figure,bar(histRed,'r');
    title('Histogram Red');
    figure,bar(histGreen,'g');
    title('Histogram Green');
    figure,bar(histBlue,'b');
    title('Histogram Blue');

% FUNGSI MENAMPILKAN HISTEQ
function histeq_Callback(hObject, eventdata, handles)
    % MENDAPATKAN IMAGE DARI DATA HANDLES
    image = handles.image
    
    % MENGINISIALISASI VARIABEL YANG DIPERLUKAN UNTUK HISTEQ
    Histeq = uint8(zeros(size(image,1),size(image,2)));
    freq=zeros(256,1);
    probf=zeros(256,1);
    probc=zeros(256,1);
    cum=zeros(256,1);
    output=zeros(256,1);
    
    % JUMLAH PIXEL DALAM IMAGE
    numofpixels = size(image,1)*size(image,2)
    
    %MENGHITUNG FREKUENSI KEMUNCULAN PADA SETIAP PIXEL
    %MENGHITUNG PROBABILITAS SETIAP KEMUNCULAN
    for i=1:size(image,1)
        for j=1:size(image,2)
            value=image(i,j);
            freq(value+1)=freq(value+1)+1;
            probf(value+1)=freq(value+1)/numofpixels;
        end
    end
    
    sum=0;
    no_bins=255;

    %MENGHITUNG CUMULATIVE DISTIRBUTION DISTRIBUTION PADA SETIAP PIXEL
    for i=1:size(probf)
       sum=sum+freq(i);
       cum(i)=sum;
       probc(i)=cum(i)/numofpixels;
       output(i)=round(probc(i)*no_bins);
    end

    %MEMASUKKAN HASIL PERHITUNGAN KEDALAM VARIABEL HISTEQ/IMAGE BARU
    for i=1:size(image,1)
        for j=1:size(image,2)
            Histeq(i,j)=output(image(i,j)+1);
        end
    end
    
    %MEMUNCULKAN IMAGE DAN HISTOGRAM HASIL DARI HISTEQ
    figure,bar(Histeq);
    figure,imshow(Histeq);
    title('Histogram equalization');

% FUNGSI BLUR GAMBAR
function blur_Callback(hObject, eventdata, handles)
    % MENDAPATKAN IMAGE DARI DATA HANDLES
    image = handles.image

    % NILAI KERNEL
    x = 1/9;
    Mask = [x x x; x x x; x x x];
    
    % GAMBAR AWAL
    [n l m] = size(image);
    img = zeros(n+2, l+2, m);
    for i = 1:m
        for j = 1:n
            for k = 1:l
                img(j+1,k+1,i) = image(j,k,i);
            end
        end
    end
    
    % GAMBAR FILTER
    newImage = zeros(n+2, l+2, m);
    [k l m] = size(img);
    
    % DIKONVOLUSI
    for h=1:m
        for i=2:k-1
            for j=2:l-1
                newImage(i,j,h) = img(i-1,j-1,h)*Mask(1,1) + img(i-1,j,h)*Mask(1,2) + img(i-1,j+1,h)*Mask(1,3) + img(i,j-1,h)*Mask(2,1) + img(i,j,h)*Mask(2,2) + img(i,j+1,h)*Mask(2,3) + img(i+1,j-1,h)*Mask(3,1) + img(i+1,j,h)*Mask(3,2) + img(i+1,j+1,h)*Mask(3,3);
            end;
        end;
    end;
    
    % HASIL AKHIR KONVOLUSI
    newImage = uint8(newImage);
    figure,imshow(newImage);
    

% FUNGSI SHARP GAMBAR
function sharp_Callback(hObject, eventdata, handles)
    % MENDAPATKAN IMAGE DARI DATA HANDLES
    image = handles.image
    
    % NILAI KERNEL
    Mask = [0 -1 0; -1 5 -1; 0 -1 0];
    
    % GAMBAR AWAL
    [n l m] = size(image);
    img = zeros(n+2, l+2, m);
    for i = 1:m
        for j = 1:n
            for k = 1:l
                img(j+1,k+1,i) = image(j,k,i);
            end
        end
    end
    
    % GAMBAR FILTER
    newImage = zeros(n+2, l+2, m);
    [k l m] = size(img);
    for h=1:m
        for i=2:k-1
            for j=2:l-1
                newImage(i,j,h) = img(i-1,j-1,h)*Mask(1,1) + img(i-1,j,h)*Mask(1,2) + img(i-1,j+1,h)*Mask(1,3) + img(i,j-1,h)*Mask(2,1) + img(i,j,h)*Mask(2,2) + img(i,j+1,h)*Mask(2,3) + img(i+1,j-1,h)*Mask(3,1) + img(i+1,j,h)*Mask(3,2) + img(i+1,j+1,h)*Mask(3,3);
            end;
        end;
    end;
    
    % HASIL AKHIR KONVOLUSI
    newImage = uint8(newImage);
    figure,imshow(newImage);

% FUNGSI EDGE DETECTION GAMBAR
function edge_Callback(hObject, eventdata, handles)
    % MENDAPATKAN IMAGE DARI DATA HANDLES
    image = handles.image
    
    % NILAI KERNEL
    Mask = [0 1 0; 1 -4 1; 0 1 0];
    
    % GAMBAR AWAL
    [n l m] = size(image);
    img = zeros(n+2, l+2, m);
    for i = 1:m
        for j = 1:n
            for k = 1:l
                img(j+1,k+1,i) = image(j,k,i);
            end
        end
    end
    
    % GAMBAR FILTER
    newImage = zeros(n+2, l+2, m);
    [k l m] = size(img);
    for h=1:m
        for i=2:k-1
            for j=2:l-1
                newImage(i,j,h) = img(i-1,j-1,h)*Mask(1,1) + img(i-1,j,h)*Mask(1,2) + img(i-1,j+1,h)*Mask(1,3) + img(i,j-1,h)*Mask(2,1) + img(i,j,h)*Mask(2,2) + img(i,j+1,h)*Mask(2,3) + img(i+1,j-1,h)*Mask(3,1) + img(i+1,j,h)*Mask(3,2) + img(i+1,j+1,h)*Mask(3,3);
            end;
        end;
    end;
    
    % HASIL AKHIR KONVOLUSI
    newImage = uint8(newImage);
    figure,imshow(newImage);
