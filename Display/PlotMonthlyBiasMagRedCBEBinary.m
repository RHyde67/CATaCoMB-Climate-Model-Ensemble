function [  ] = PlotMonthlyBiasMagRedCBEBinary( handles )
%PLOTMONTHLYABSBIAS plots the Monthly Actual Bias
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
% Plots and saves the bias magnitude between the cluster based ensemble, detailed in
% the paper above, and the satellite observations.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%%
Folder = sprintf('..\\Outputs\\MonthlyBiasMagnitudeReductionBinary');

CBEBiasRedMagBinary = getappdata(handles.figure1, 'CBEBiasRedMag');
CBEBiasRedMagBinary(CBEBiasRedMagBinary>0)=1;
CBEBiasRedMagBinary(CBEBiasRedMagBinary<0)=-1;
Lat = unique(getappdata(handles.figure1, 'LatOrig'));
Lon = unique(getappdata(handles.figure1, 'LonOrig'));
[X,Y] = meshgrid(Lat, Lon);

hF = figure(1);
clf
worldmap('World');
setm(gca, 'Origin', [0 180 0]);
land = shaperead('landareas', 'UseGeoCoords', true);
geoshow(gca, land, 'DefaultEdgeColor', 'k', 'FaceColor', 'none');
colormap(redblue);

for Month = 1:12
    Bias = permute(CBEBiasRedMagBinary(Month,:,:), [2,3,1]);
    surfacem(X,Y,Bias);
    title(sprintf('(%s) Month %i', char(Month+96),...
        Month))
    Plots = findobj(gca,'Type','Axes');
    Plots.SortMethod = 'depth';
    set(gcf, 'Color', 'w');
    
    cd(Root);
    try cd(Folder)
    catch
        mkdir (Folder)
        cd (Folder)
    end
    FileName = sprintf('MonthlyBiasMagRedBinaryMonth%i.png', Month);
    if Month/4 == floor(Month/4)
        export_fig(hF, FileName, '-m4',10, '-c[290, NaN, 435, NaN]');
    else
        export_fig(hF, FileName, '-m4',10, '-c[290, NaN, 435, NaN]');
    end
    
end

Files = dir('*.png');
[~, idx] = sort({Files.date});
Files = Files(idx);
Files = flipud(Files);
figure(99)
clf
imdisp({Files.name}, 'Size', [3,4], 'Indices', [12,11,10,9,8,7,6,5,4,3,2,1]);
set(gcf, 'Color', 'w');
hFMontage = figure(99);
export_fig(hFMontage,  '-m2', 'MonthlyBiasMagRedBinary.pdf');
end
