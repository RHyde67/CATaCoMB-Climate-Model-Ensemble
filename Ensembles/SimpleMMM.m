function [ ] = SimpleMMM( handles )
%SIMPLEMMM Generates a basic MMM using all the available data.
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
% Generates a simple MMM using the mean values of the data at each spatial location.
% Inputs:
%   handles: handles to GUI
% Outputs:
% None - data is stored int he GUI space

%% get data from GUI
Ozone = getappdata(handles.figure1,'OrigOzone');

SimpleMMM = permute(mean( Ozone , 1),[2,3,4,1]); % mean of all models for Month

setappdata(handles.figure1,'SimpleMMM',SimpleMMM);

end % end function
