function [ ] = SigmaTruth( handles )
%SIGMATRUTH Calculates predicted truth omitting data outside n-sigma
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
% Generates prdicted truth values using only data within 1-sigma of the
% mean
% Inputs:
%   handles: handles to GUI
% Outputs:
%   None - data is saved in the GUI space

%% get data from GUI
ModelOzone = getappdata(handles.figure1,'OrigOzone');
ScaledOzone = getappdata(handles.figure1,'ScaledOzone');

NumSigma = 1; % hard coded as 1-sigma. Make user selectable in GUI for future?

% set values outside 1-sigma to NaN
ModelOzone( abs(ModelOzone - mean(ModelOzone,1)) >...
    NumSigma * nanstd(ModelOzone,1)) = NaN;
PredictedTruthSigma = permute(nanmean(ModelOzone,1),[2,3,4,1]);

ScaledOzone( abs(ScaledOzone - mean(ScaledOzone,1)) >...
    NumSigma * nanstd(ScaledOzone,1)) = NaN;
PredictedTruthSigmaScaled = permute(nanmean(ScaledOzone,1),[2,3,4,1]);


%% save to gui
setappdata(handles.figure1,'PredictedTruth',PredictedTruthSigma);
setappdata(handles.figure1,'PredictedTruthScaled',PredictedTruthSigmaScaled);

end

