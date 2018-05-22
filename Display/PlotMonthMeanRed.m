function [ ] = PlotMonthMeanRed( handles )
%PLOTMONTHMEANRED Plots the monthly mean bias reduction
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
% Plots and saves the mean monthly bias reduction as a percentage of the simple MMM
% bias.

if(~isdeployed)
  Root = fileparts(which(mfilename));
  cd(Root);
else
    Root=[];
end
%%
Folder = sprintf('..\\Outputs\\MonthlyBiasReduction%s%s');

MMMBias = getappdata(handles.figure1, 'BiasSimpleMMM');
CBEBiasRedMag = getappdata(handles.figure1, 'CBEBiasRedMag');
SigmaBiasRedMag = getappdata(handles.figure1, 'SigmaEnsembleRedMag');

MeanCBERedPerc = mean(mean(CBEBiasRedMag,2),3)./mean(mean(abs(MMMBias),2),3)*100;;
MeanSigmaRedPerc = mean(mean(SigmaBiasRedMag,2),3)./mean(mean(abs(MMMBias),2),3)*100;

hF = figure(1);
hold off
plot(MeanCBERedPerc,'-*', 'LineWidth',2, 'MarkerSize',10)
hold on
plot(MeanSigmaRedPerc,'-o', 'LineWidth',2, 'MarkerSize',10)
plot([0,13],[0,0],'r--')

axis([0 13 -5 30])
xlabel('Month')
ylabel('Error Reduction Percentage')
title(sprintf('Monthly Mean Bias Reduction vs SimpleEnsemble'))
set(gca,'FontSize',12)

LegendString = {'DDC', 'Sigma Mean'};
legend(LegendString);

cd(Root);
    try cd(Folder)
    catch
        mkdir (Folder)
        cd (Folder)
    end
    FileName = sprintf('MonthlyBiasReduction.pdf');
    export_fig(hF, FileName);

end

