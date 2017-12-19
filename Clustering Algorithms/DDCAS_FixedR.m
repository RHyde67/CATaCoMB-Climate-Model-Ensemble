 function [Clusters, DataClustered]=DDCAS_FixedR(varargin)
% R Hyde 04/09/2017
% Copyright R Hyde 2017
% Released under the GNU GPLver3.0
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/
% If you use this file please acknowledge the author and cite as a
% reference:
% TBC
%
% DDC offline Clustering
% Function created for use with RASCAL Climate Analysis, uses fixed
% micro-cluster radii for compatability with CODAS and CEDAS
% Inputs:
%   DataIn: All the  current data
%   InitialRadius: Initial radius of cluster for DDC routine
%   MinThresh: minimum number of data samples per micro-cluster to be
%   considered cluter not noise
%   ReturnData: flag to return clustered data, if zero only micro-clusters
%   are returned
% Outputs:
%   Clusters: Structure containing the cluster Clusters.Centres and radii for each
%   data group.
%   DataClustered: Array of original data with micro-cluster number
%   appended
% 

DataIn=varargin{1};
InitialRadius=varargin{2};
MinThresh=varargin{3};
ReturnData=varargin{4};

% TotalSamples=size(DataIn,1);
% NumColours=25;
% ColourList=distinguishable_colors(NumColours);

%%
Clusters.Centre=[];
Clusters.Radius=[];
MicroClusterNumber=0; % number of current cluster being created
Clusters=[];
NumDims=size(DataIn,2);
Outliers=[];
DataClustered=[];

tic
while size (DataIn,1)>MinThresh
    MicroClusterNumber=MicroClusterNumber+1;
    %% Find densest point - closest to global mean
    GlobalMean=nanmean(DataIn,1); % array of means of data dims
    Dist=pdist2(GlobalMean, DataIn);
    [~,idx1]=min(Dist);
    Clusters.Centre(MicroClusterNumber,:)=DataIn(idx1,:); % assign cluster Clusters.Centre
    DataIn(idx1,:)=[]; % remove from available data
    
    %% find all sample in cluster radius
    Dist=pdist2(Clusters.Centre(MicroClusterNumber,:),DataIn); % find distances to Clusters.Centre
    [In,idx]=find(Dist<InitialRadius); % find distance within radius
    Clusters.Count(MicroClusterNumber,:)=sum(In)+1; % sum all included, add centre
    Clusters.Radius(MicroClusterNumber,:)=InitialRadius;
    if ReturnData==1
        DataClustered=[DataClustered;[DataIn(idx,:),repmat(MicroClusterNumber,size(DataIn(idx,:),1),1)];...
            Clusters.Centre(MicroClusterNumber,:), MicroClusterNumber];
    end
    DataIn(idx,:)=[]; % remove data within the cluster

end  

if ReturnData==1 % append remaining data as outliers in their own micro-cluster
    for idx1=1:size(DataIn,1)
        MicroClusterNumber=MicroClusterNumber+1;
        DataClustered=[DataClustered;DataIn(idx1,:),MicroClusterNumber];
        Clusters.Centre(MicroClusterNumber,:) = DataIn(idx1,:);
        Clusters.Count(MicroClusterNumber,:) = 1;
        Clusters.Radius(MicroClusterNumber,:) = InitialRadius;
    end
end
    

%% Remove outlier micro-clusters based on number of sample
idx2 = find(Clusters.Count > MinThresh); % find acceptable clusters

%%
Dist=pdist2(Clusters.Centre,Clusters.Centre);
Clusters.Global=zeros(size(Clusters.Centre,1),1);

for idx=idx2'
    
    SumRads=Clusters.Radius(idx,:)+0.5*Clusters.Radius(idx,:);
    Intersects=find(Dist(idx,:)'<=SumRads);
    Intersects = Intersects(ismember(Intersects,idx2)); % ### bug fix, remove to return to previous operation
    Globals2Change=unique(Clusters.Global(Intersects));
    Globals2Change=Globals2Change(Globals2Change~=0);
    if Globals2Change
        Clusters.Global(Intersects)=Globals2Change(1,1);
        for idx3=Globals2Change'
            Clusters.Global(Clusters.Global==idx3)=Globals2Change(1,1);
        end
    else
        Clusters.Global(Intersects)=max(Clusters.Global)+1;
    end
end

if ReturnData==1
    DataClustered(:,end)=Clusters.Global(DataClustered(:,end));
end

%% ### END ###

