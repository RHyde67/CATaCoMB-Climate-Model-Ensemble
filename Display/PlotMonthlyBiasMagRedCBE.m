function [  ] = PlotMonthlyBiasMagRedCBE( handles )
%PLOTMONTHLYABSBIAS plots the Monthly Bias reduction
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
% Plots and saves the monthly bias reduction when comparing the cluster based
% ensemble and the simple MMM.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%%
Folder = sprintf('..\\Outputs\\MonthlyBiasMagnitudeReduction');

CBEBiasRedMag = getappdata(handles.figure1, 'CBEBiasRedMag');
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
    Bias = permute(CBEBiasRedMag(Month,:,:), [2,3,1]);
    
    hCM = contourfm(X, Y, Bias, -5:1:5, 'LineStyle', 'none');
    hCB = contourcbar;
    title(hCB,sprintf('Bias Red\n(DU)'), 'FontSize', 10, 'FontWeight', 'bold');
    caxis([-5, 5])
    title(sprintf('(%s) Month %i, Mean %.2f DU, Integrated %.1f DU', char(Month+96),...
        Month, mean(Bias(:)), sum(Bias(:)) ))
    Plots = findobj(gca,'Type','Axes');
    Plots.SortMethod = 'depth';
    set(gcf, 'Color', 'w');
    
     % write to file
    cd(Root);
    try cd(Folder)
    catch
        mkdir (Folder)
        cd (Folder)
    end
    FileName = sprintf('MonthlyBiasMagRedMonth%i.png', Month);
    if Month/4 == floor(Month/4)
        export_fig(hF, FileName, '-m4',10, '-c[290, NaN, 435, NaN]');
    else
        export_fig(hF, FileName, '-m4',10, '-c[290, 450, 435, NaN]');
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
export_fig(hFMontage, '-m2', 'MonthlyBiasMagRedValues.pdf');
end
