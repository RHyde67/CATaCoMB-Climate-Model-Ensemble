function [ ] = DDC_Ensemble2( handles )
%DDC_ENSEMBLE2 Summary of this function goes here
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
% Generates a cluster based MMM
% Inputs:
%   handles: handles to GUI
% Outputs:
%   None - data is stored in the GUI space

%% get data from GUI
MonthClusters = getappdata(handles.figure1, 'MonthClusters');
MonthResults = getappdata( handles.figure1, 'MonthResults');
LatData = getappdata(handles.figure1,'LatOrig');
LonData = getappdata(handles.figure1,'LonOrig');

% additional data
ModelCountYear = getappdata(handles.figure1,'ModelCountYear');  % count number of time model is used at each location (only applies to yearly etc analysis)
ClusterUsed = getappdata(handles.figure1,'ClusterUsed'); % get array of clusters used by location
ClusterLatRad = getappdata(handles.figure1,'ClusterLatRad');
ClusterLonRad = getappdata(handles.figure1,'ClusterLonRad');
ClusterOzoneRad = getappdata(handles.figure1,'ClusterOzoneRad');

%% Setup ensmble
Lat = unique(LatData);
Lon = unique(LonData);
CBEMonth = zeros(12, size(Lon,1), size(Lat,1)); % pre-allocate memory for All monthly CBE

for Month = 1 : size(MonthClusters,2)
    CBE = zeros(size(Lon,1), size(Lat,1)); % pre-allocate memory for CBE
    Res4Ens = permute(MonthResults(Month,:,:),[2,3,1]); % [lat, lon, O3, cluster, model]
    TruthModel = max(Res4Ens(:,end)); % Truth always appended so is highest number 'model'

    for LonIdx = 1:size(Lon,1)
        for LatIdx = 1:size(Lat,1)
            % find all the data at the location being considered
            DataAtLoc = Res4Ens(Res4Ens(:,1)==Lat(LatIdx) & Res4Ens(:,2)==Lon(LonIdx),:);
            % find cluster with 'Truth' value in it
            CorrectCluster = DataAtLoc(DataAtLoc(:,5)==TruthModel,4);
            CorrectClusterMean = nanmean(DataAtLoc(DataAtLoc(:,4)==CorrectCluster,3));
            CBE(LonIdx,LatIdx) = CorrectClusterMean;
            % Additional Info
            ModelsUsed = DataAtLoc(DataAtLoc(:,4)==CorrectCluster,5);
            ModelCountYear(LonIdx, LatIdx, ModelsUsed) = ModelCountYear(LonIdx, LatIdx, ModelsUsed)+1;
            ClusterLatRad(LonIdx, LatIdx, Month) = MonthClusters(Month).Rad(CorrectCluster,1);
            ClusterLonRad(LonIdx, LatIdx, Month) = MonthClusters(Month).Rad(CorrectCluster,2);
            ClusterOzoneRad(LonIdx, LatIdx, Month) = MonthClusters(Month).Rad(CorrectCluster,3);
            ClusterUsed(LonIdx, LatIdx, Month) = CorrectCluster;
        end
    end
    CBEMonth(Month,:,:) = CBE;
end % end month loop

setappdata(handles.figure1,'ModelCountYear', ModelCountYear);  % count number of time model is used at each location (only applies to yearly etc analysis)
setappdata(handles.figure1,'ClusterUsed', ClusterUsed); % array of clusters used by location
setappdata(handles.figure1,'ClusterLatRad', ClusterLatRad);
setappdata(handles.figure1,'ClusterLonRad', ClusterLonRad);
setappdata(handles.figure1,'ClusterOzoneRad', ClusterOzoneRad);
setappdata(handles.figure1,'CBEMonth', CBEMonth);

end % end function

