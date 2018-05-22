function [ ] = ShowPlots( handles )
%SHOWPLOTS plot images for journal paper
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
%   Plots and save images according to the check boxes on the gui. Images
%   are displayed and saved.

StatusOutput( handles, 'Starting plots...');

if handles.checkMonthBiasRed.Value == 1
    StatusOutput( handles, 'Plotting monthly mean bias reduction (Fig 2)');
    PlotMonthMeanRed( handles )
end

if handles.checkMonthBiasSimple.Value == 1
    StatusOutput( handles, 'Plotting monthly bias simpleMMM (Fig 3)');
    PlotMonthlyBiasSimple( handles )
end

if handles.checkMonthBiasCBE.Value == 1
    StatusOutput( handles, 'Plotting monthly bias CBE (Fig 4)');
    PlotMonthlyBiasCBE( handles )
end

if handles.checkMonthBiasAbsSimple.Value == 1
    StatusOutput( handles, 'Plotting monthly bias magnitude MMM (Fig 5)');
    PlotMonthlyBiasMagSimple( handles )
end

if handles.checkMonthBiasAbsCBE.Value == 1
    StatusOutput( handles, 'Plotting monthly bias magnitude CBE (Fig 6)');
    PlotMonthlyBiasMagCBE( handles )
end

if handles.checkMonthBiasAbsRed.Value == 1
    StatusOutput( handles, 'Plotting monthly bias magnitude reduction (Fig 7)');
    PlotMonthlyBiasMagRedCBE( handles );
end

if handles.checkMonthBiasRedBinary.Value == 1
    StatusOutput( handles, 'Plotting monthly binary bias magnitude reduction (Fig 8)');
    PlotMonthlyBiasMagRedCBEBinary( handles );
end

if handles.checkClusterRatio.Value == 1
    StatusOutput( handles, 'Plotting cluster ratios histogram (Fig 9)');
    PlotClusterRatioHist( handles );
end

if handles.checkClusterRatioMap.Value == 1
    StatusOutput( handles, 'Plotting cluster ratios (Fig 10)');
    PlotMonthlyClusterRatio( handles );
end

if handles.checkYearModelUse.Value == 1
    StatusOutput( handles, 'Plotting yearly model use (Fig 11)');
    PlotYearlyModelUse( handles );
end

if handles.checkOzoneRad.Value == 1
    StatusOutput( handles, 'Plotting Ozone Radii Histogram (Fig A1)');
    PlotOzoneRadii( handles );
end

if handles.checkBiasHist.Value == 1
    StatusOutput( handles, 'Plotting Bias Change Histogram (Fig A2)');
    PlotBiasChangeHist( handles );
end

StatusOutput( handles, 'Plots completed.');
end

