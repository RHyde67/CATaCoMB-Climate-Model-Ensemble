function [  ] = ScaleData( handles )
%SETSCALES Sets scaling factors for data
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
%   Normalises data 0-1 based on latitude *or longitude being 0-1, the
%   other is scaled to same range, so spatial radii should be equal. Ozone
%   is scaled separately as described.

StatusOutput (handles, 'Scaling data....');

%% get data from GUI
ModelData = getappdata(handles.figure1,'ModelData');
ObsData = getappdata(handles.figure1,'ObsData');

%% Scale Lat Lon
LatOrig = ModelData.Lat;
LonOrig = ModelData.Lon;

LatMin = min(ModelData.Lat(:)); % minimum lat grid value
LatRange = range(ModelData.Lat(:)); % lat grid range (number of grids)

LonMin = min(ModelData.Lon(:)); % minimum lat grid value
LonRange = range(ModelData.Lon(:)); % lat grid range (number of grids)

%% Scale lat and Lon either to same scale ( choose either Lat or Lon to be 0-1 ), or individually both (0-1) as per original
% Lat 0-1
MinLat = LatMin;
RangeLat = LatRange;
% Lon 0-1
MinLon = LonMin;
RangeLon = LonRange;

ScaledLat = ( ModelData.Lat - MinLat ) / RangeLat;
ScaledLon = ( ModelData.Lon - MinLon ) / RangeLon;

GridDistance = [5/RangeLat, 5/RangeLon];


%% Scale Ozone
for idx1 = 1:12 % for each month
    OD = ModelData.Ozone(:,idx1,:,:); % grab all model ozone data for month
    Mi = min(OD(:)); % minimum value of all models for month
    Ma = max(OD(:)); % maximum value of all models for month
    Ra = Ma-Mi; % range of all ozone values for month
    Av = mean(OD(:)); % mean of all ozone values (not used)
    SD = std(OD(:)); % std dev of all ozone values for month
    SD1(idx1,:,:,:) = std(OD,1); % find std dev at each location, each month
    SD2 = mean(SD1(:)); % mean of std dev at each loc each month
    Res(idx1,:)=[Mi,Ma,Ra,Av,SD, SD2]; % store all in a results array
end
Res = array2table(Res, 'VariableNames',{'MonthMin', 'MonthMax',...
    'MonthRange', 'MonthMean', 'StdDevMonth', ' MeanGridStdDevMonth'});
Min2Use = mean(Res.MonthMin); % mean of all the monthly minimums
Range2Use = mean(Res.MonthRange); % mean of all the monthly ranges
ScaledOzone = ( ModelData.Ozone - Min2Use ) / Range2Use;
ScaledObsOzone = (ObsData.Ozone - Min2Use ) / Range2Use;

% set Ozone radius
% RadO3 = mean(Res.StdDevMonth) / mean(Res.MonthRange); % mean std dev of all months scaled to the range
RadO3 = mean(Res.MeanGridStdDevMonth) / mean(Res.MonthRange) *2 ;% mean grid std dev by month scaled to range
% some other method based on model std devs
% RadO3 = handles.O3TestRad; % #### USE FOR TEST LOOPING ONLY ####
% RadO3 = 0.15; % 0.15 tests result in steps of 0.025
handles.editO3Rad.String = sprintf('%.5f',RadO3);

%% save data to GUI
setappdata(handles.figure1,'LatOrig', LatOrig);
setappdata(handles.figure1,'LonOrig', LonOrig);
setappdata(handles.figure1,'ScaledLat', ScaledLat);
setappdata(handles.figure1,'ScaledLon', ScaledLon);
setappdata(handles.figure1,'GridDistance',GridDistance);
setappdata(handles.figure1, 'ScaledOzone', ScaledOzone);
setappdata(handles.figure1, 'ScaledObsOzone', ScaledObsOzone);
setappdata(handles.figure1, 'OrigOzone', ModelData.Ozone);
setappdata(handles.figure1, 'RadO3', RadO3);
setappdata(handles.figure1, 'OzoneScale', Range2Use);
end

