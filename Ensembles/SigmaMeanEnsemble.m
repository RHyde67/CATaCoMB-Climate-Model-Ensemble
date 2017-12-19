function [ ] = SigmaMeanEnsemble( handles )
%SIGMAMEANENSEMBLE Generates an MMM using only data within n-sigma of the
% mean. Default n=1
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
% Inputs:
%   handles: handles to GUI
% Outputs:
%   none - data is stored i the GUI space.

%% get data from GUI
ModelOzone = getappdata(handles.figure1,'OrigOzone');
ScaledOzone = getappdata(handles.figure1,'ScaledOzone');

NumSigma = 1; % hard coded as 1-sigma. Make user selectable in GUI for future?

% set values outside 1-sigma to NaN
ModelOzone( abs(ModelOzone - mean(ModelOzone,1)) >...
    NumSigma * nanstd(ModelOzone,1)) = NaN;
SigmaEnsemble = permute(nanmean(ModelOzone,1),[2,3,4,1]);

ScaledOzone( abs(ScaledOzone - mean(ScaledOzone,1)) >...
    NumSigma * nanstd(ScaledOzone,1)) = NaN;
SigmaEnsembleScaled = permute(nanmean(ScaledOzone,1),[2,3,4,1]);


%% save to gui
setappdata(handles.figure1,'SigmaEnsemble',SigmaEnsemble);
setappdata(handles.figure1,'SigmaEnsembleScaled',SigmaEnsembleScaled);
end

