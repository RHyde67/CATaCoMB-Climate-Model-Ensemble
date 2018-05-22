function [ ] = PlotBiasChangeHist( handles )
%PLOTBIASHIST Plots histogram of bias change
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
% Displays and saves a histogram of the magnitude of bias reduction by using the
% cluster based ensemble in preference to the simple MMM.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%% Simple MMM Bias
Folder = ('..\Outputs\BiasChangeHist');
FileName = (sprintf('BiasChangeHist.pdf'));

CBEBiasRedMag = getappdata(handles.figure1, 'CBEBiasRedMag');
MeanChange = mean(CBEBiasRedMag(:));
IntChange = sum(CBEBiasRedMag(:));

hF = figure(1);
histogram(CBEBiasRedMag(:),-6:0.5:6,'FaceColor','b')
title(sprintf('Bias Change: Mean %.2f DU, Integrated %.0f DU', MeanChange, IntChange));
xlabel('Bias Change (DU)');
ylabel('Occurences');

% write to file
cd(Root);
try cd(Folder)
catch
    mkdir (Folder)
    cd (Folder)
end
export_fig(hF, FileName);
end

