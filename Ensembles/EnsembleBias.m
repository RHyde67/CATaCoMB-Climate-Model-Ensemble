function [  ] = EnsembleBias( handles )
%ENSEMBLEBIAS Calculates the ensemble bias from observations
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
% Calculates the ensemble bias comparing the MMM to observation data
% Inputs:
%   Handles: handles to the GUI
% Outputs:
%   none - data is stored in the GUI space

StatusOutput( handles, 'Calculating ensemble biases...');

ObsData = getappdata(handles.figure1, 'ObsData');
ObsOzone = ObsData.Ozone;
SimpleMMM = getappdata(handles.figure1, 'SimpleMMM');
SigmaMMM = getappdata(handles.figure1, 'SigmaEnsemble');
CBE = getappdata(handles.figure1, 'CBEMonth');

BiasSimpleMMM = SimpleMMM - ObsOzone;
BiasSigmaEnsemble = SigmaMMM - ObsOzone;
BiasCBE = CBE - ObsOzone;

setappdata(handles.figure1, 'BiasSimpleMMM', BiasSimpleMMM);
setappdata(handles.figure1, 'BiasSigmaEnsemble', BiasSigmaEnsemble);
setappdata(handles.figure1, 'BiasCBE', BiasCBE);

end

