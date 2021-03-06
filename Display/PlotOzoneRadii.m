function [ ] = PlotOzoneRadii( handles )
% PLOTOZONERADII Plots histogram of final ozone radii
% Copyright R Hyde 2017
% Released under the GNU GPLver3.0
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/
% This file forms part of the demonstration software, known as CATaCoMB.
% If you use this file please acknowledge the author and cite as a
% reference:
% Hyde R, Hossaini R, Leeson A (2018) Cluster-based analysis of multi-model
% climate ensembles. Geosci Model Dev Discuss 1�28 . doi: 10.5194/gmd-2017-317
%
% Plots and saves the histogram of the final cluster radii in the Ozone dimension as
% used in the paper noted above.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%% Simple MMM Bias
Folder = ('..\Outputs\OzoneRadii');

FileName = (sprintf('OzoneRadHist.pdf'));

ClusterOzoneRad = getappdata(handles.figure1, 'ClusterOzoneRad');
ClusterOzoneRad = ClusterOzoneRad(:);
ClusterOzoneRad(ClusterOzoneRad == -999) = [];
OzoneScale = getappdata(handles.figure1, 'OzoneScale')

hF = figure(1);
histogram(ClusterOzoneRad * OzoneScale, 10,'FaceColor','b')
title('Final O_{3} Radii');
xlabel('O_{3} Radius');
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

