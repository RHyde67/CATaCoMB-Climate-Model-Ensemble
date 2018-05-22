function [ ] = PlotYearlyModelUse( handles )
%UNTITLED Plots maps of the climate models used
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
% Plots and saves a mercator map of the use of each climate model over the year.
% Climate model names are redacted.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%% Simple MMM Bias
Folder = ('..\Outputs\YearlyModelUse');

ModelCount = getappdata(handles.figure1, 'ModelCountYear');
Lat = unique(getappdata(handles.figure1, 'LatOrig'));
Lon = unique(getappdata(handles.figure1, 'LonOrig'));
[X,Y] = meshgrid(Lat, Lon);

hF = figure(1);
clf
worldmap('World');
setm(gca, 'Origin', [0 180 0]);
land = shaperead('landareas', 'UseGeoCoords', true);
geoshow(gca, land, 'DefaultEdgeColor', 'm', 'FaceColor', 'none', 'LineWidth',0.5);
% colormap(bone) % ### change this line to invert colorbar ###
colormap(flipud(hot));
colormap(flipud(jet));
for Model=1:14
    ModelNumbers = ModelCount(:,:,Model);
    SM = surfacem(X,Y,ModelNumbers);
    title(sprintf('(%s) Model %s Inclusion',...
        char(Model+96),char(Model+64)));
    Plots = findobj(gca,'Type','Axes');
    Plots.SortMethod = 'depth';
    hCB = colorbar;
    title(hCB,sprintf('No. Months\n Included'), 'FontSize', 10, 'FontWeight', 'bold');
    set(gcf, 'Color', 'w');
    
    cd(Root);
    try cd(Folder)
    catch
        mkdir (Folder)
        cd (Folder)
    end
    FileName = sprintf('YearlyModelUse%s.png',...
        char(Model+64));

    if Model/4 == floor(Model/4) | Model == 14
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
imdisp({Files.name}, 'Size', [4,4], 'Indices', [14,13,12,11,10,9,8,7,6,5,4,3,2,1]);
set(gcf, 'Color', 'w');
hFMontage = figure(99);
export_fig(hFMontage,  '-m2', 'YearlyModelUse.pdf');

end

