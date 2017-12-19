function varargout = CatacombePaper(varargin)
% CATACOMBEPAPER MATLAB code for CatacombePaper.fig
% Copyright R Hyde 2017
% Released under the GNU GPLver3.0
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/
% This file forms part of the demonstration software, known as CATaCoMB.
% If you use this file please acknowledge the author and cite as a
% reference:
% Cluster-Based Ensemble Means for Climate Model Intercomparison
% TBC
%
% This file is the main code for the GUI to reproduce the analysis and
% figures used onthe aforementioned paper.
%
%      CATACOMBEPAPER, by itself, creates a new CATACOMBEPAPER or raises the existing
%      singleton*.
%
%      H = CATACOMBEPAPER returns the handle to a new CATACOMBEPAPER or the handle to
%      the existing singleton*.
%
%      CATACOMBEPAPER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CATACOMBEPAPER.M with the given input arguments.
%
%      CATACOMBEPAPER('Property','Value',...) creates a new CATACOMBEPAPER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CatacombePaper_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CatacombePaper_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CatacombePaper

% Last Modified by GUIDE v2.5 18-Dec-2017 16:54:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CatacombePaper_OpeningFcn, ...
                   'gui_OutputFcn',  @CatacombePaper_OutputFcn, ...
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


% --- Executes just before CatacombePaper is made visible.
function CatacombePaper_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CatacombePaper (see VARARGIN)

% Choose default command line output for CatacombePaper
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CatacombePaper wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CatacombePaper_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushStart.
function pushStart_Callback(hObject, eventdata, handles)
% hObject    handle to pushStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isempty(getappdata(handles.figure1,'ResultsTable'))
ResultsTable = array2table(zeros(0,21), 'VariableNames', {'ClusType', 'Truth',...
    'LatRad', 'LonRad', 'LatNumGrids', 'LonNumGrids', 'O3Rad',...
    'M1BiasRed',  'M2BiasRed', 'M3BiasRed', 'M4BiasRed', 'M5BiasRed', 'M6BiasRed',...
    'M7BiasRed', 'M8BiasRed', 'M9BiasRed', 'M10BiasRed', 'M11BiasRed', 'M12BiasRed',...
    'MeanYearBiasRed',...
    'SumYearBiasRed'});
setappdata(handles.figure1,'ResultsTable',ResultsTable); % used to save all tests carried out since start for later analysis
end

MainControl(handles);


% --- Executes on button press in checkMonthBiasCBE.
function checkMonthBiasCBE_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasCBE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasCBE


% --- Executes on button press in checkYearBias.
function checkYearBias_Callback(hObject, eventdata, handles)
% hObject    handle to checkYearBias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkYearBias


% --- Executes on button press in checkMonthBiasAbsSimple.
function checkMonthBiasAbsSimple_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasAbsSimple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasAbsSimple


% --- Executes on button press in checkYearBiasMag.
function checkYearBiasMag_Callback(hObject, eventdata, handles)
% hObject    handle to checkYearBiasMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkYearBiasMag


% --- Executes on button press in checkMonthBiasMagRed.
function checkMonthBiasMagRed_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasMagRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasMagRed


% --- Executes on button press in checkYearBiasMagRed.
function checkYearBiasMagRed_Callback(hObject, eventdata, handles)
% hObject    handle to checkYearBiasMagRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkYearBiasMagRed


% --- Executes on button press in checkMonthModelUse.
function checkMonthModelUse_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthModelUse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthModelUse


% --- Executes on button press in checkYearModelUse.
function checkYearModelUse_Callback(hObject, eventdata, handles)
% hObject    handle to checkYearModelUse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkYearModelUse


% --- Executes on button press in checkMapLongRadMonth.
function checkMapLongRadMonth_Callback(hObject, eventdata, handles)
% hObject    handle to checkMapLongRadMonth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMapLongRadMonth


% --- Executes on button press in checkMapLatRadMonth.
function checkMapLatRadMonth_Callback(hObject, eventdata, handles)
% hObject    handle to checkMapLatRadMonth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMapLatRadMonth


% --- Executes on button press in checkMapO3RadMonth.
function checkMapO3RadMonth_Callback(hObject, eventdata, handles)
% hObject    handle to checkMapO3RadMonth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMapO3RadMonth


% --- Executes on button press in checkMapRadLonYearMean.
function checkMapRadLonYearMean_Callback(hObject, eventdata, handles)
% hObject    handle to checkMapRadLonYearMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMapRadLonYearMean


% --- Executes on button press in checkMapLonRadYearMean.
function checkMapLonRadYearMean_Callback(hObject, eventdata, handles)
% hObject    handle to checkMapLonRadYearMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMapLonRadYearMean


% --- Executes on button press in checkMapO3YearMean.
function checkMapO3YearMean_Callback(hObject, eventdata, handles)
% hObject    handle to checkMapO3YearMean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMapO3YearMean


% --- Executes on selection change in popCluster.
function popCluster_Callback(hObject, eventdata, handles)
% hObject    handle to popCluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popCluster contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popCluster

% --- Executes during object creation, after setting all properties.
function popCluster_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popCluster (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.String={'DDC'};


% --- Executes on selection change in popTruth.
function popTruth_Callback(hObject, eventdata, handles)
% hObject    handle to popTruth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popTruth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popTruth

% --- Executes during object creation, after setting all properties.
function popTruth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popTruth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
hObject.String={'Simple','Sigma'};




% --- Executes on button press in pushPlot.
function pushPlot_Callback(hObject, eventdata, handles)
% hObject    handle to pushPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ShowPlots( handles );



function editGridLat_Callback(hObject, eventdata, handles)
% hObject    handle to editGridLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editGridLat as text
%        str2double(get(hObject,'String')) returns contents of editGridLat as a double


% --- Executes during object creation, after setting all properties.
function editGridLat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editGridLat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',1.5) % defaults = 1.5



function editGridLon_Callback(hObject, eventdata, handles)
% hObject    handle to editGridLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editGridLon as text
%        str2double(get(hObject,'String')) returns contents of editGridLon as a double


% --- Executes during object creation, after setting all properties.
function editGridLon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editGridLon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',2.5) % defaults = 2.5


function editO3Rad_Callback(hObject, eventdata, handles)
% hObject    handle to editO3Rad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editO3Rad as text
%        str2double(get(hObject,'String')) returns contents of editO3Rad as a double


% --- Executes during object creation, after setting all properties.
function editO3Rad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editO3Rad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkMonthBiasSimple.
function checkMonthBiasSimple_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasSimple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasSimple


% --- Executes on button press in checkMonthBiasSaveSimple.
function checkMonthBiasSaveSimple_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasSaveSimple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasSaveSimple


% --- Executes on button press in checkMonthBiasAbsCBE.
function checkMonthBiasAbsCBE_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasAbsCBE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasAbsCBE


% --- Executes on button press in checkMonthBiasAbsSaveCBE.
function checkMonthBiasAbsSaveCBE_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasAbsSaveCBE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasAbsSaveCBE


% --- Executes on button press in checkMonthBiasAbsRed.
function checkMonthBiasAbsRed_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasAbsRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasAbsRed


% --- Executes on button press in checkMonthlyBiasRedBinary.
function checkMonthlyBiasRedBinary_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthlyBiasRedBinary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthlyBiasRedBinary


% --- Executes on button press in checkMonthBiasRed.
function checkMonthBiasRed_Callback(hObject, eventdata, handles)
% hObject    handle to checkMonthBiasRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkMonthBiasRed
