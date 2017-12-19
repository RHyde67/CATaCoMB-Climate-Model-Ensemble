function [ ] = SimpleTruth( handles )
%SIMPLETRUTH Predicts simple truth (arithmetic mean)
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
% Generates predicted truth values using all the available data, i.e. a
% simple arithmetic mean of the data at each location.
% Inputs:
%   handles: handles to GUI
% Outputs:
%   None - data is saved in hte GUI space

%% get data from GUI
ModelOzone = getappdata(handles.figure1,'OrigOzone');
ScaledOzone = getappdata(handles.figure1,'ScaledOzone');

PredictedTruth = permute(mean( ModelOzone , 1),[2,3,4,1]); % mean of all models for Month
PredictedTruthScaled = permute(mean( ScaledOzone , 1),[2,3,4,1]); % scaled mean of all models for Month

setappdata(handles.figure1,'PredictedTruth',PredictedTruth);
setappdata(handles.figure1,'PredictedTruthScaled',PredictedTruthScaled);

end % end function
