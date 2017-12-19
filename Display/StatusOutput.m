function [ ] = StatusOutput( handles, NewString )
%STATUSOUTPUT Summary of this function goes here
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
% Passes progress status messages to a GUI window.
% Inputs:
%   handles: GUI handles
%   NewString: string to display in GUI window
% Outputs:
%   None

if isempty (handles.textStatus.String)
    handles.textStatus.String = cell(29,1);
end

Text = handles.textStatus.String;
Text(1)=[];
Text{end+1} = NewString;
handles.textStatus.String = Text;
drawnow
end

