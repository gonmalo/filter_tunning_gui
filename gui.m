function varargout = filter_tunning(varargin)
% FILTER_TUNNING MATLAB code for filter_tunning.fig
%      FILTER_TUNNING, by itself, creates a new FILTER_TUNNING or raises the existing
%      singleton*.
%
%      H = FILTER_TUNNING returns the handle to a new FILTER_TUNNING or the handle to
%      the existing singleton*.
%
%      FILTER_TUNNING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FILTER_TUNNING.M with the given input arguments.
%
%      FILTER_TUNNING('Property','Value',...) creates a new FILTER_TUNNING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before filter_tunning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to filter_tunning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help filter_tunning

% Last Modified by GUIDE v2.5 09-Aug-2012 12:45:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @filter_tunning_OpeningFcn, ...
                   'gui_OutputFcn',  @filter_tunning_OutputFcn, ...
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


% --- Executes just before filter_tunning is made visible.
function filter_tunning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to filter_tunning (see VARARGIN)

% Choose default command line output for filter_tunning
handles.output = hObject;

% Lectura de imagenes
% handles.im = imread('chi_bol4.jpg');       % Lectura de imagen
handles.im = imread('prueba_1.jpg');
handles.iml = rgb2hsl2(handles.im);                % Imagen en HSL

% parametros filtro
handles.alpha1 = 0.412;
handles.alpha2 = 0.412;
handles.umbral = 0.5;
handles.weight = 0.5;
handles.shiftgain = 15;

% Canal de luminancia
handles.imL = handles.iml(:,:,3);
handles.imS = handles.iml(:,:,2);
% Luminancia filtrada
handles.imf  = handles.imL;
handles.imfs = handles.imL; 
handles.imfr = handles.imL; 
handles.imfw = handles.imL; 

% Extras
handles.filt1 = 0;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes filter_tunning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = filter_tunning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_alpha1_Callback(hObject, eventdata, handles)
temp = str2double(get(handles.edit_alpha1, 'String'));
if ~rango(temp)
  set(hObject,'String','')
else
  handles.alpha1 = temp;
  filtrar(hObject, eventdata, handles)
  plotear_alpha(hObject, eventdata, handles)
end
guidata(hObject, handles);

function edit_alpha1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_alpha2_Callback(hObject, eventdata, handles)
temp = str2double(get(handles.edit_alpha2, 'String'));
if ~rango(temp)
  set(hObject,'String','')
else
  handles.alpha2 = temp;
  filtrar(hObject, eventdata, handles)
  plotear_alpha(hObject, eventdata, handles)
end
guidata(hObject, handles);

function edit_alpha2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_umbral_Callback(hObject, eventdata, handles)
temp = str2double(get(handles.edit_umbral, 'String'));
if ~rango(temp)
  set(hObject,'String','')
else
  handles.umbral = temp;
  filtrar(hObject, eventdata, handles)
  plotear_alpha(hObject, eventdata, handles)
end
guidata(hObject, handles);

function edit_umbral_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_shifting_Callback(hObject, eventdata, handles)
temp = str2double(get(handles.edit_shifting, 'String'));
if ~rango(temp)
  set(hObject,'String','')
else
  handles.shiftgain = 1/temp;
  filtrar(hObject, eventdata, handles)
  plotear_shifting(hObject, eventdata, handles)
end
guidata(hObject, handles);

function edit_shifting_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function filt_1_Callback(hObject, eventdata, handles)
if get(hObject, 'Value')
  set(handles.filt_3, 'Value', 0);
end
filtrar(hObject, eventdata, handles)

function filt_2_Callback(hObject, eventdata, handles)
if get(hObject, 'Value')
  set(handles.filt_3, 'Value', 0);
end
filtrar(hObject, eventdata, handles)

function filt_3_Callback(hObject, eventdata, handles)
if get(handles.filt_3, 'Value')
  set(handles.filt_1, 'Value', 0);
  set(handles.filt_2, 'Value', 0);
end
filtrar(hObject, eventdata, handles)


function slider_weight_Callback(hObject, eventdata, handles)
handles.weight = get(hObject, 'Value');
if get(handles.filt_3, 'Value')
  filtrar(hObject, eventdata, handles)
end

function slider_weight_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Funciones propias
function filtrar(hObject, eventdata, handles)
% Shifting
pix = handles.imL;
factor = round(handles.imL.*255+1);
t = (1-gausswin(256))./handles.shiftgain; t = t';
i = find (handles.imL < 0.5); 

pix(i) = handles.imL(i) +  t(factor(i))' ;%.*(imS(i) > 0.15);
% handles.imSf = handles.imS;
% handles.imSf(i) = handles.imS(i) + (.03*(handles.imS(i) < .96));
handles.imfs = pix;

% Retinex
if get(handles.filt_1, 'Value')
  pix = handles.imfs;
else
  pix = handles.imL;
end
mx = max(max(pix));
mn = min(min(pix));
dif = mx - mn;
alphaa = (pix >  handles.umbral).*handles.alpha2 + ...
         (pix <= handles.umbral).*handles.alpha1;
G = pix.^(alphaa.*pix+alphaa);
S = (G - mn) ./ dif;

O = G.*S;
handles.imfr = O;

% Weighted
handles.imfw = handles.imfs.*(1-handles.weight) + ...
               handles.imfr.*handles.weight;

% Selector de salida
if get(handles.filt_3, 'Value')
  handles.imf = handles.imfw;  
elseif get(handles.filt_2, 'Value')
  handles.imf = handles.imfr;
elseif get(handles.filt_1, 'Value')
  handles.imf = handles.imfs;
else
  handles.imf = handles.imL;
end

guidata(hObject, handles);
plotear(hObject, eventdata, handles);


function plotear(hObject, eventdata, handles)
imagesc(handles.im, 'parent', handles.plot_1)
title(handles.plot_1,'Imagen Original' ,'fontsize',12, 'fontweight', 'bold')

handles.iml(:,:,3) = handles.imf;
% handles.iml(:,:,2) = handles.imSf;
imagesc(hsl2rgb(handles.iml), 'parent', handles.plot_2)
title(handles.plot_2,'Imagen Filtrada','fontsize',12, 'fontweight', 'bold')

histplot = imhist(handles.imL);
bar(handles.plot_hist1, histplot)
xlim(handles.plot_hist1, [0 255])

histplot = imhist(handles.imf);
bar(handles.plot_hist2, histplot)
xlim(handles.plot_hist2, [0 255])

imwrite(hsl2rgb(handles.iml), 'salida.jpg')

guidata(hObject, handles);

function plotear_alpha(hObject, eventdata, handles)
pix = linspace(0,1,256);
alphaa = (pix >  handles.umbral).*handles.alpha2 + ...
         (pix <= handles.umbral).*handles.alpha1;
G = pix.^(alphaa.*pix+alphaa);
plot(handles.plot_alpha, G)
title(handles.plot_alpha,'Función \gamma(\alpha)','fontsize',10, 'fontweight', 'bold')
ylim(handles.plot_alpha, [0 1])
xlim(handles.plot_alpha, [0 255])
grid(handles.plot_alpha)

function plotear_shifting(hObject, eventdata, handles)
t = (1-gausswin(256))./handles.shiftgain; t = t';
plot(handles.plot_alpha, t)
title(handles.plot_alpha,'Curva de Shifting','fontsize',10, 'fontweight', 'bold')
% ylim(handles.plot_alpha, [0 1])
xlim(handles.plot_alpha, [0 127])
grid(handles.plot_alpha)

function ok = rango(temp)
if strcmp(num2str(temp),'NaN')
  f = errordlg( ...
    'EL valor ingresado no es un número. Ingrese un número entre 0 y 1', ...
    'Error de valor');
  ok = 0;
elseif  temp < 0 || temp > 1
  f = errordlg( ...
    'EL número ingresado está fuera del rango válido. Ingrese un número entre 0 y 1', ...
    'Error de valor');
  ok = 0;
else
  ok = 1;
end

%%%%% Selector de Imagen de entrada
function menu_img_input_Callback(hObject, eventdata, handles)
n = get(hObject, 'Value');
handles.im = imread(strcat(handles.images(n,:),'.jpg'));
handles.iml = rgb2hsl2(handles.im);
handles.imL = handles.iml(:,:,3);
handles.imf  = handles.imL;
handles.imfs = handles.imL; 
handles.imfr = handles.imL; 
handles.imfw = handles.imL; 

guidata(hObject, handles);

plotear(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function menu_img_input_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
handles.images = busca_jpg;
set(hObject,'String',handles.images);

guidata(hObject, handles);



% --- Desabilitado.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
