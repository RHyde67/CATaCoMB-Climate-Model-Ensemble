function [ ModelData, ObsData ] = ReadDataACCMIP( handles )
%READMODELDATA Loads climate model data
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
%   Reads data from climate model output files
% At this time only Ozone (O3) is used for test purposes and this is the
% only data in the files.
% Outputs:
%   ModelData: A structure contining model data, listed by index, the
%   index is the order in which the data files are read.
%       ModelData.ModelName: a cell array of the model names
%       ModelData.Ozone: a 4D array of doubles [ model number, Month,
%       Longitude, Latitude]
%       ModelData.Lon: a 2D array of doubles with the longitude values for
%           each model. (Not necessary at this time, but future uses include
%           models with different spatial resolutions)
%       ModelData.Lat: as per Lon, but atitude values.
%   ObsData: A similar structure to ModelData, but containing only
%   observation data.

if(~isdeployed)
  cd(fileparts(which(mfilename)));
end

%% Set data paths
ModelPath = '..\Source Data\Model';
ObsPath = '..\Source Data\Observations';

%% Read observation data
StatusOutput (handles, 'Reading observation data....');
AvailableFiles = dir((fullfile(ObsPath, '*.nc'))); % list available data files
baseFileName = AvailableFiles.name;
% fprintf(1, 'Reading %s\n', baseFileName);
fullFileName = fullfile(ObsPath, baseFileName);
ObsData.Model(1)=cellstr('Observation');
ObsData.Ozone=permute(ncread(fullFileName,'o3tppcol'),[3,1,2]);
ObsData.Lon=ncread(fullFileName,'lon');
ObsData.Lat=ncread(fullFileName,'lat');
  
  %% Read model data
AvailableFiles = dir((fullfile(ModelPath, '*.nc'))); % list available data files
ModelData=[];
StatusOutput (handles, 'Reading model data');
for idx1 = 1:length(AvailableFiles)
  handles.textStatus.String(end,1) = strcat(handles.textStatus.String(end,1),'.');
  baseFileName = AvailableFiles(idx1).name;
%   fprintf(1, 'Reading %s\n', baseFileName);
  fullFileName = fullfile(ModelPath, baseFileName);

  %% Correct model names to suitable format
  modelname=strsplit(baseFileName,'_');
  modelname=char(modelname(1,3));
  
  ModelData.Model(idx1)=cellstr(modelname);
  ModelData.Ozone(idx1,:,:,:)=permute(ncread(fullFileName,'o3tppcol'),[3,1,2]);
  ModelData.Lon(idx1,:)=ncread(fullFileName,'lon');
  ModelData.Lat(idx1,:)=ncread(fullFileName,'lat');
  ModelData.StdDev(idx1,:,:,:) = permute(ncread(fullFileName,'sdev'),[3,1,2]);  
end % end data read loop

% remove unusable data columns due to observation spatial limits
UsableCols = any(any(~isnan(ObsData.Ozone),1),2); % find limits of observation region
UsableCols=reshape(UsableCols,size(UsableCols,2),size(UsableCols,3));
ModelData.Ozone = ModelData.Ozone(:,:,:,UsableCols);
ModelData.Lat = ModelData.Lat(:,UsableCols);
ObsData.Ozone = ObsData.Ozone(:,:,UsableCols);
ObsData.Lat = ObsData.Lat(UsableCols);

%% Save data to GUI
setappdata(handles.figure1,'ModelData', ModelData);
setappdata(handles.figure1,'ObsData', ObsData);
end % end function



