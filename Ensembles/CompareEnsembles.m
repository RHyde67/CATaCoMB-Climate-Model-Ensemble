function [ ] = CompareEnsembles( handles )
%COMPAREENSEMBLES Compare CBE bias to simple-MMM bias
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
% Generates comparison between climate model ensembles data;
% Inputs:
%   handles: GUI handles
% Outputs:
%   None, data is saved in the GUI space

StatusOutput( handles, 'Comparing ensembles to Simple MMM...');

BiasSimpleMMM = getappdata(handles.figure1, 'BiasSimpleMMM');
BiasSigmaEnsemble = getappdata(handles.figure1, 'BiasSigmaEnsemble');
BiasCBE = getappdata(handles.figure1, 'BiasCBE');

CBEBiasChange = BiasSimpleMMM - BiasCBE;
CBEBiasRedMag = abs(BiasSimpleMMM) - abs(BiasCBE);
SigmaBiasRedMag = abs(BiasSimpleMMM) - abs(BiasSigmaEnsemble);

setappdata(handles.figure1, 'CBEBiasChange', CBEBiasChange);
setappdata(handles.figure1, 'CBEBiasRedMag', CBEBiasRedMag);
setappdata(handles.figure1, 'SigmaEnsembleRedMag', SigmaBiasRedMag);

end

