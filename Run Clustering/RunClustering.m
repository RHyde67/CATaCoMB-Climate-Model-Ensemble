function [ ] = RunClustering( handles )
%RUNCLUSTERING runs appropriate clustering
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
% Runs DDC clustering on scaled data and back-references to original data
% values to generate clusters of original data.
% Inputs:
%   handles: handles to GUI
% Outputs:
%   none - data is saved in the GUI space

Scaled_Unscaled = 0; % 0 - scaled, 1 - unscaled (use of unscaled data not implemented)

if Scaled_Unscaled == 0
    % scaled data for clustering
    ScaledLat = getappdata(handles.figure1,'ScaledLat');
    ScaledLon = getappdata(handles.figure1,'ScaledLon');
    GridDistances = getappdata(handles.figure1,'GridDistance');
    PredictedTruthScaled = getappdata(handles.figure1, 'PredictedTruthScaled');
    ScaledOzone = getappdata(handles.figure1, 'ScaledOzone');
    ScaledOzone(15,:,:,:) = PredictedTruthScaled;
    ScaledObsOzone = getappdata(handles.figure1, 'ScaledObsOzone');
    RadOzone = getappdata(handles.figure1, 'RadO3');
    
    % original values for results
    OrigOzone = getappdata(handles.figure1,'OrigOzone');
    PredictedTruth = getappdata(handles.figure1,'PredictedTruth');
    OrigOzone(15,:,:,:) = PredictedTruth;
    LatOrig = getappdata(handles.figure1, 'LatOrig');
    LonOrig = getappdata(handles.figure1, 'LonOrig');
    [X, Y] = meshgrid(LatOrig(1,:),LonOrig(1,:));
    LatLonOrig = repmat([X(:),Y(:)], 15, 1);
    ObsOrig = getappdata(handles.figure1, 'ObsData');
    
    [X, Y] = meshgrid(ScaledLat(1,:),ScaledLon(1,:));
    LatLon = repmat([X(:),Y(:)], 15, 1);
    
    % Convert to 2D arrays for clustering
    for Month = 1 : 12
        Temp = permute(ScaledOzone(:, Month, :, :), [3,4,1,2]);
        Ozone4Cluster(:,Month) = Temp(:);
        Temp = permute(OrigOzone(:, Month, :, :), [3,4,1,2]);
        Ozone(:,Month) = Temp(:);
    end
    ModelNum = ones(1656,15).*[1:15];

    % set number of grid spaces for radii
    NumLatGrids = str2double(handles.editGridLat.String);
    NumLonGrids = str2double(handles.editGridLon.String);
    RadLat = ceil(GridDistances(1,1) * NumLatGrids*1000)/1000; % round to 3 dec places
    RadLon = ceil(GridDistances(1,2) * NumLonGrids*1000)/1000;

    StatusOutput( handles, 'Clustering...');
    tic
    if handles.popCluster.Value == 1
        for Month = 1:12
            StatusOutput( handles, sprintf('Clustering month %i...', Month));
            Data4Cluster = [LatLon,Ozone4Cluster(:,Month)];

             % generate cluster results, cluster results are not in the same order as sent
            [Clusters, Results1] = DDC_ver01_1_ACCMIP(Data4Cluster, [RadLat, RadLon, RadOzone], 0, 0);
            % return results to original order
            [~, idx1] = ismember(Data4Cluster, Results1(:,1:3), 'rows'); % indices in results where data is found
            Results = [LatLonOrig,Ozone(:,Month),Results1(idx1,end),ModelNum(:)]; % [lat, lon, O3, Cluster, Model]
            
            MonthClusters(Month) = Clusters;
            MonthResults(Month,:,:) = Results;
            MonthResultsScaled(Month,:,:) = Results1;
        end
    elseif handles.popCluster.Value == 2
        % DDCAS
    end
    t2=toc;
    setappdata(handles.figure1, 'MonthClusters', MonthClusters);
    setappdata( handles.figure1, 'MonthResults', MonthResults);
    setappdata(handles.figure1, 'InitRadLat', RadLat);
    setappdata(handles.figure1, 'InitRadLon', RadLon');
    setappdata(handles.figure1, 'NumLatGrid', NumLatGrids);
    setappdata(handles.figure1, 'NumLonGrid',NumLonGrids);
    setappdata(handles.figure1, 'MonthResultsScaled', MonthResultsScaled);
    StatusOutput( handles, sprintf('Clustered in %.2f...',t2));

else % for unsclaed data - not implemented
    
end % if...then
end % end function

