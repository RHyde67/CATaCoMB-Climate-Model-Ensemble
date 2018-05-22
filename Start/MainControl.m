function [ ] = MainControl( handles )
%MAINCONTROL Controls all functions
% Controls all functions, plots and tables
% Copyright R Hyde 2017
% Released under the GNU GPLver3.0
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/
% This file forms part of the demonstration software, known as CATaCoMB.
% If you use this file please acknowledge the author and cite as a
% reference:
% Hyde R, Hossaini R, Leeson A (2018) Cluster-based analysis of multi-model
% climate ensembles. Geosci Model Dev Discuss 1–28 . doi: 10.5194/gmd-2017-317
% 
%
% Main function to run the sub-functions for analysis
% Inputs:
%   handles: handles to GUI
% Outputs:
%   None - data is saved in GUI space by each sub-function

%% set storage
setappdata(handles.figure1,'ModelCountYear',zeros(72,23,15)); % used to count number of times a model is used, set to zeros initially, incremented in ensemble function
setappdata(handles.figure1,'ClusterUsed',zeros(72,23,12)); % used to store cluster used at each locatio
setappdata(handles.figure1,'ClusterLatRad',zeros(72,23,12)); % used to store radii of cluster used at each location
setappdata(handles.figure1,'ClusterLonRad',zeros(72,23,12)); % used to store radii of cluster used at each location
setappdata(handles.figure1,'ClusterOzoneRad',zeros(72,23,12)); % used to store radii of cluster used at each location
setappdata(handles.figure1,'ClusterLonRadYear',zeros(72,23,12)); % used to store radii of cluster over the year
setappdata(handles.figure1,'OzoneMonthSimple',zeros(72,23,12)); % used to store simple MMM ozone values
setappdata(handles.figure1,'ClusterOzoneRadYear',zeros(72,23,12)); % used to store radii of cluster over the year
setappdata(handles.figure1,'MeanOzoneMonthSimple',zeros(1,12)); % used to store simple MMM ozone values
setappdata(handles.figure1,'StdDevOzoneMonthSimple',zeros(1,12)); % used


%% Import Data
ReadDataACCMIP( handles );

%% Scale data and set radii (with unscaled alternative)
ScaleData ( handles );
% UnscaledRadii( handles );

%% Simple MMM
SimpleMMM ( handles );

%% Sigme Mean Ensemble
SigmaMeanEnsemble( handles )

%% Predicted Truth
StatusOutput (handles, 'Predicting truth....');
% TruthType = handles.popTruth.Value;
% if TruthType == 1
% SimpleTruth ( handles );
% elseif TruthType == 2
%     SigmaTruth ( handles );
% else
%     StatusOutput( handles, 'Truth type selection error...');
% end

%% Cluster
RunClustering (handles);

%% Generate Ensemble
GenerateEnsemble( handles );

%% Ensemble Bias
EnsembleBias( handles );

%% Compare CBE with simple MMM
CompareEnsembles( handles )

%%
%% Display and Save Plots
% handled by push button

%% Save test data
% SaveTestData( handles )

%% End of analysis
StatusOutput( handles, 'Analysis complete, ready to plot.');
end % end function

