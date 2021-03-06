function varargout = project(varargin)
%digunakan untuk melewatkan sejumlah input atau mengembalikan sejumlah output ke sebuah fungsi.
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_OpeningFcn, ...
                   'gui_OutputFcn',  @project_OutputFcn, ...
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


% --- Executes just before project is made visible.
function project_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

function varargout = project_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

image_folder = '.\Training\mature';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);
Z1=[];
for n = 1:total_images
  full_name= fullfile(image_folder, filenames(n).name);
  Img = imread(full_name); 
  
%cari nilai HSI
RGB     = im2double(Img);
Red     = RGB(:,:,1);
Green   = RGB(:,:,2);
Blue    = RGB(:,:,3);
%Hue
atas=1/2*((Red-Green)+(Red-Blue));
bawah=((Red-Green).^2+((Red-Blue).*(Green-Blue))).^0.5;
teta = acosd(atas./(bawah));
if Blue >= Green
    H = 360 - teta;
else
    H = teta;
end

H = H/360;
[r c] = size(H);
for i=1 : r
    for j=1 : c
        z = H(i,j);
        z(isnan(z)) = 0;
        H(i,j) = z;
    end
end

%S
S=1-(3./(sum(RGB,3))).*min(RGB,[],3);
[r c] = size(S);
for i=1 : r
    for j=1 : c
        z = S(i,j);
        z(isnan(z)) = 0;
        S(i,j) = z;
    end
end
%I
I=(Red+Green+Blue)/3;

MeanR = mean2(Red);
MeanG = mean2(Green);
MeanB = mean2(Blue);
MeanH = mean2(H);
MeanS = mean2(S);
MeanI = mean2(I);
VarRed = var(Red(:)); 
VarGreen = var(Green(:)); 
VarBlue = var(Blue(:));
VarH = var(H(:)); 
VarS = var(S(:)); 
VarI = var(I(:));
RangeR = ((max(max(Red)))-(min(min(Red))));
RangeG = ((max(max(Green)))-(min(min(Green))));
RangeB = ((max(max(Blue)))-(min(min(Blue))));
RangeH = ((max(max(H)))-(min(min(H))));
RangeS = ((max(max(S)))-(min(min(S))));
RangeI = ((max(max(I)))-(min(min(I))));

sdR = std2(Red);
sdG = std2(Green);
sdB = std2(Blue);
sdH = std2(H);
sdS = std2(S);
sdI = std2(I);


Z=[MeanR MeanG MeanB MeanH MeanS MeanI VarRed VarGreen VarBlue VarH VarS VarI RangeR RangeG RangeB RangeH RangeS RangeI sdR sdG sdB sdH sdS sdI 1];
Z1=[Z1;Z];
end

image_folder = '.\Training\half-mature';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

for n = 1:total_images
  full_name= fullfile(image_folder, filenames(n).name);
  Img = imread(full_name); 
  
%cari nilai HSI
RGB     = im2double(Img);
Red     = RGB(:,:,1);
Green   = RGB(:,:,2);
Blue    = RGB(:,:,3);
%Hue
atas=1/2*((Red-Green)+(Red-Blue));
bawah=((Red-Green).^2+((Red-Blue).*(Green-Blue))).^0.5;
teta = acosd(atas./(bawah));
if Blue >= Green
    H = 360 - teta;
else
    H = teta;
end

H = H/360;
[r c] = size(H);
for i=1 : r
    for j=1 : c
        z = H(i,j);
        z(isnan(z)) = 0;
        H(i,j) = z;
        %untuk memeriksa apakah parameter yang non-numerik
    end
end

%S
S=1-(3./(sum(RGB,3))).*min(RGB,[],3);
[r c] = size(S);
for i=1 : r
    for j=1 : c
        z = S(i,j);
        z(isnan(z)) = 0;
        S(i,j) = z;
    end
end
%I
I=(Red+Green+Blue)/3;

MeanR = mean2(Red);%Nilai Rata-Rata 
MeanG = mean2(Green);
MeanB = mean2(Blue);
MeanH = mean2(H);
MeanS = mean2(S);
MeanI = mean2(I);
VarRed = var(Red(:)); 
VarGreen = var(Green(:)); 
VarBlue = var(Blue(:));
VarH = var(H(:)); 
VarS = var(S(:)); 
VarI = var(I(:));
RangeR = ((max(max(Red)))-(min(min(Red))));
RangeG = ((max(max(Green)))-(min(min(Green))));
RangeB = ((max(max(Blue)))-(min(min(Blue))));
RangeH = ((max(max(H)))-(min(min(H))));
RangeS = ((max(max(S)))-(min(min(S))));
RangeI = ((max(max(I)))-(min(min(I))));

sdR = std2(Red);%Menghitung Standar Deviasi Data 
sdG = std2(Green);%menghitung bagaimana nilai data tersebar
sdB = std2(Blue);
sdH = std2(H);
sdS = std2(S);
sdI = std2(I);


Z=[MeanR MeanG MeanB MeanH MeanS MeanI VarRed VarGreen VarBlue VarH VarS VarI RangeR RangeG RangeB RangeH RangeS RangeI sdR sdG sdB sdH sdS sdI 2];
Z1=[Z1;Z];
end

image_folder = '.\Training\immature';
filenames = dir(fullfile(image_folder, '*.jpg'));
total_images = numel(filenames);

for n = 1:total_images
  full_name= fullfile(image_folder, filenames(n).name);
  Img = imread(full_name); 
  
%cari nilai HSI
RGB     = im2double(Img);
Red     = RGB(:,:,1);
Green   = RGB(:,:,2);
Blue    = RGB(:,:,3);
%Hue
atas=1/2*((Red-Green)+(Red-Blue));
bawah=((Red-Green).^2+((Red-Blue).*(Green-Blue))).^0.5;
teta = acosd(atas./(bawah));
if Blue >= Green
    H = 360 - teta;
else
    H = teta;
end

H = H/360;
[r c] = size(H);
for i=1 : r
    for j=1 : c
        z = H(i,j);
        z(isnan(z)) = 0;
        H(i,j) = z;
    end
end

%S
S=1-(3./(sum(RGB,3))).*min(RGB,[],3);
[r c] = size(S);
for i=1 : r
    for j=1 : c
        z = S(i,j);
        z(isnan(z)) = 0;
        S(i,j) = z;
    end
end
%I
I=(Red+Green+Blue)/3;

MeanR = mean2(Red);
MeanG = mean2(Green);
MeanB = mean2(Blue);
MeanH = mean2(H);
MeanS = mean2(S);
MeanI = mean2(I);
VarRed = var(Red(:)); 
VarGreen = var(Green(:)); 
VarBlue = var(Blue(:));
VarH = var(H(:)); 
VarS = var(S(:)); 
VarI = var(I(:));
RangeR = ((max(max(Red)))-(min(min(Red))));
RangeG = ((max(max(Green)))-(min(min(Green))));
RangeB = ((max(max(Blue)))-(min(min(Blue))));
RangeH = ((max(max(H)))-(min(min(H))));
RangeS = ((max(max(S)))-(min(min(S))));
RangeI = ((max(max(I)))-(min(min(I))));

sdR = std2(Red);
sdG = std2(Green);
sdB = std2(Blue);
sdH = std2(H);
sdS = std2(S);
sdI = std2(I);


Z=[MeanR MeanG MeanB MeanH MeanS MeanI VarRed VarGreen VarBlue VarH VarS VarI RangeR RangeG RangeB RangeH RangeS RangeI sdR sdG sdB sdH sdS sdI 3];
Z1=[Z1;Z];
end

xlswrite('Data Training',Z1);
set(handles.edit1,'string','Training Color Done');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)


% pisah rgb
Img = handles.I;
%cari nilai HSI
RGB     = im2double(Img);
Red     = RGB(:,:,1);
Green   = RGB(:,:,2);
Blue    = RGB(:,:,3);
%Hue
atas=1/2*((Red-Green)+(Red-Blue));
bawah=((Red-Green).^2+((Red-Blue).*(Green-Blue))).^0.5;
teta = acosd(atas./(bawah));
if Blue >= Green
    H = 360 - teta;
else
    H = teta;
end

H = H/360;
[r c] = size(H);
for i=1 : r
    for j=1 : c
        z = H(i,j);
        z(isnan(z)) = 0; %isnan adalah is not none artinya jika bukan angka dia akan memberi 0
        H(i,j) = z;
    end
end
%S
S=1-(3./(sum(RGB,3))).*min(RGB,[],3);
[r c] = size(S);
for i=1 : r
    for j=1 : c
        z = S(i,j);
        z(isnan(z)) = 0;
        S(i,j) = z;
    end
end
%I
I=(Red+Green+Blue)/3;

MeanR = mean2(Red);
MeanG = mean2(Green);
MeanB = mean2(Blue);
MeanH = mean2(H);
MeanS = mean2(S);
MeanI = mean2(I);
VarRed = var(Red(:)); VarGreen = var(Green(:)); VarBlue = var(Blue(:));
VarH = var(H(:)); VarS = var(S(:)); VarI = var(I(:));
RangeR = ((max(max(Red)))-(min(min(Red))));
RangeG = ((max(max(Green)))-(min(min(Green))));
RangeB = ((max(max(Blue)))-(min(min(Blue))));
RangeH = ((max(max(H)))-(min(min(H))));
RangeS = ((max(max(S)))-(min(min(S))));
RangeI = ((max(max(I)))-(min(min(I))));

data = get(handles.uitable2,'Data');
data{1,1} = num2str(MeanR);
data{2,1} = num2str(MeanG);
data{3,1} = num2str(MeanB);
data{4,1} = num2str(MeanH);
data{5,1} = num2str(MeanS);
data{6,1} = num2str(MeanI);

data{1,2} = num2str(VarRed);
data{2,2} = num2str(VarGreen);
data{3,2} = num2str(VarBlue);
data{4,2} = num2str(VarH);
data{5,2} = num2str(VarS);
data{6,2} = num2str(VarI);

data{1,3} = num2str(RangeR);
data{2,3} = num2str(RangeG);
data{3,3} = num2str(RangeB);
data{4,3} = num2str(RangeH);
data{5,3} = num2str(RangeS);
data{6,3} = num2str(RangeI);

set(handles.uitable2,'Data',data,'ForegroundColor',[0 0 0])
training1 = xlsread('Data Training');
group = training1(:,25);
training = [training1(:,1) training1(:,2) training1(:,3) training1(:,4) training1(:,5) training1(:,6) training1(:,7) training1(:,8) training1(:,9) training1(:,10) training1(:,11) training1(:,12) training1(:,13) training1(:,14) training1(:,15) training1(:,16) training1(:,17) training1(:,18)];
Z=[MeanR MeanG MeanB MeanH MeanS MeanI VarRed VarGreen VarBlue VarH VarS VarI RangeR RangeG RangeB RangeH RangeS RangeI];
hasil1=knnclassify(Z,training,group);

if hasil1==1
    x='MATANG';
elseif hasil1==2
    x='SETENGAH MATANG';
elseif hasil1==3
    x='BELUM MATANG';
end
set(handles.edit2,'string',x);


function uitable2_CellEditCallback(hObject, eventdata, handles)

function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)

function edit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile('*.jpg');
Img = imread(fullfile(pathname,filename));
handles.I = Img;
guidata(hObject,handles)
axes(handles.axes2)
imshow(Img)
title(filename);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

