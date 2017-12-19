function [ ] = PlotYearlyModelUse( handles)
%UNTITLED Summary of this function goes here
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
geoshow(gca, land, 'DefaultEdgeColor', 'm', 'FaceColor', 'none', 'LineWidth',1.0);
% colormap(bone) % ### change this line to invert colorbar ###
colormap(flipud(hot));
colormap(flipud(jet));
for Model=1:14
    ModelNumbers = ModelCount(:,:,Model);
    SM = surfacem(X,Y,ModelNumbers);
    title(sprintf('Model %s Inclusion',...
        char(Model+64)));
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
    FileName = sprintf('YearlyModelUse%s%s%s.png',...
        handles.popCluster.String{handles.popCluster.Value},...
    handles.popTruth.String{handles.popTruth.Value},...
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
export_fig(hFMontage,  '-m2', 'YearlyModelUse');

end

