function [  ] = PlotMonthlyClusterRatio( handles )
%PLOTMONTHLYCLUSTERRATIO plots the Monthly Ratio of Cluster 1: Cluster 2
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
% Plots and saves a mercator map of the cluster ratios, i.e. the number of members of
% the clusters 1 & 2. This provides an indication of the number of models
% rejected from the CBE compared to those kept.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%% CBE Bias
Folder = sprintf('..\\Outputs\\MonthlyClusterRatioMap'); % generate folder name for saving plots

ClusterRatio = getappdata(handles.figure1, 'ClusterRatio');
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
    CR = permute(ClusterRatio(:,:, Month), [1,2,3]);
    
    hCM = contourfm(X, Y, CR, 10, 'LineStyle', 'none');
    hCB = contourcbar;
    title(hCB,'Ratio', 'FontSize', 10, 'FontWeight', 'bold');
    caxis([0,1])
    title(sprintf('(%s) Month %i', char(Month+96), Month ))
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

    FileName = sprintf('MonthlyClusterRatio%i.png', Month);
    if Month/4 == floor(Month/4) % don't include colourbars in all plots
        export_fig(hF, FileName, '-m4',10, '-c[290, NaN, 435, NaN]');
    else
        export_fig(hF, FileName, '-m4',10, '-c[290, 470, 435, NaN]');
    end
%     end
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
export_fig(hFMontage, '-m2', sprintf('MonthlyClusterRatioMap.pdf'));
end
