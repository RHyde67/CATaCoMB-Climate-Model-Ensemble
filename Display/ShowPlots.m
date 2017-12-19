function [ ] = ShowPlots( handles )
%SHOWPLOTS plot images for journal paper
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
%   Plots and save images according to the check boxes on the gui. Images
%   be displayed and saved, or displayed only. Not currently saved without
%   display

StatusOutput( handles, 'Starting plots...');

if handles.checkMonthBiasSimple.Value == 1
    StatusOutput( handles, 'Plotting monthly bias');
    PlotMonthlyBiasSimple( handles )
end

if handles.checkMonthBiasCBE.Value == 1
    StatusOutput( handles, 'Plotting monthly bias');
    PlotMonthlyBiasCBE( handles )
end

if handles.checkMonthBiasAbsSimple.Value == 1
    StatusOutput( handles, 'Plotting monthly bias magnitude');
    PlotMonthlyBiasMagSimple( handles )
end

if handles.checkMonthBiasAbsCBE.Value == 1
    StatusOutput( handles, 'Plotting monthly bias magnitude');
    PlotMonthlyBiasMagCBE( handles )
end

if handles.checkMonthBiasAbsRed.Value == 1
    StatusOutput( handles, 'Plotting monthly bias magnitude reduction');
    PlotMonthlyBiasMagRedCBE( handles );
end

if handles.checkMonthBiasRedBinary.Value == 1
    StatusOutput( handles, 'Plotting monthly bias magnitude reduction');
    PlotMonthlyBiasMagRedCBEBinary( handles );
end

if handles.checkYearModelUse.Value == 1
    StatusOutput( handles, 'Plotting yearly model use...');
    PlotYearlyModelUse( handles );
end

StatusOutput( handles, 'Plots completed.');
end

