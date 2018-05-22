function [ ] = PlotClusterRatioHist( handles )
%PLOTCLUSTERRATIOHIST Plots histogram of cluster size ratios
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
% Displays and saves a histogram of the ratio of memberships between clusters 1 and
% 2.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%% Cluster Ratio
Folder = sprintf('..\\Outputs\\MonthlyClusterRatioHist'); % generate folder name for saving plots
FileName = (sprintf('ClusterRatioHist.png'));

ClusterRatio = getappdata(handles.figure1, 'ClusterRatio');

hF = figure(1);
histogram(ClusterRatio(:),10,'FaceColor','b')
title('Ratio of Cluster Membership (Cluster2 / Custer 1)');
xlabel('Ratio');
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

