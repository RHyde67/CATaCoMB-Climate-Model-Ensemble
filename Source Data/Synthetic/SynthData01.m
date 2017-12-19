function [ SynthModelData, SynthObsData ] = SynthData01(  )
%SYNTHDATA01 Generate synthetis data set
%   This function generates a synthetic data set for illustrating he
%   cluster based ensemble approach. 9 randomised values around Matlabs
%   'peaks' function are generated with both a spatial and readings offset.
%   A 10th one clearly offset. The clearly offset values should be removed
%   by the cluster based ensemble.
%   A new figure window is opened ouside of the main GUI to display the generated data.

% Generate offset synthetic data
Month = 1;
NumPoints = 50;
% Base data
SynthObsData.Model = {'Truth'};
[BX,BY,SynthObsData.Ozone] = peaks(NumPoints);
SynthObsData.Lat = BX(1,:);
SynthObsData.Lon = BY(:,1);

% SynthModelData.Ozone(1,:,:) = SynthObsData.Ozone;

for idx =1:2:9
% Offset X
SynthModelData.Ozone(idx,Month,:,:) = [SynthObsData.Ozone(3:end,:);SynthObsData.Ozone(1:2,:)];
Offset = rand(1,1,NumPoints,NumPoints)/10;
SynthModelData.Ozone(idx,Month,:,:) = SynthModelData.Ozone(idx,Month,:,:) + Offset;
SynthModelData.Ozone(idx+1,Month,:,:) = SynthModelData.Ozone(idx,Month,:,:) - Offset;
% Offset Y
SynthModelData.Ozone(idx,Month,:,:) = [SynthObsData.Ozone(:,2:end),SynthObsData.Ozone(:,1:1)];
Offset = rand(1,1,NumPoints,NumPoints)/10;
SynthModelData.Ozone(idx,Month,:,:) = SynthModelData.Ozone(idx,Month,:,:) + Offset;
SynthModelData.Ozone(idx+1,Month,:,:) = SynthModelData.Ozone(idx,Month,:,:) - Offset;

% Offset Z
SynthModelData.Ozone(idx,Month,:,:) = (SynthObsData.Ozone);
Offset = rand(1,1,NumPoints,NumPoints)/1;
SynthModelData.Ozone(idx,Month,:,:) = SynthModelData.Ozone(idx,Month,:,:) + Offset;
SynthModelData.Ozone(idx+1,Month,:,:) = SynthModelData.Ozone(idx,Month,:,:) - Offset;

end

% Big Offset
Temp = [SynthObsData.Ozone(6:end,:);SynthObsData.Ozone(1:5,:)];
Temp = [Temp(:,2:end),Temp(:,1:1)];
Temp = Temp - 10;
SynthModelData.Ozone(idx+1,Month,:,:) = Temp;

% Store lat, Lon
SynthModelData.Lat(Month,:) = BX(1,:);
SynthModelData.Lon(Month,:) = BY(:,1);

for idx = 1: size(SynthModelData.Ozone,1)
    SynthModelData.Model(idx) = {sprintf('Model_%i',idx)};
end

% Display synth data
figure(2)
hold off
Cols = distcols(20);
% show observations
O3 = SynthObsData.Ozone;
ColsPlot(:,:,1) = zeros(size(O3));
ColsPlot(:,:,2) = zeros(size(O3));
ColsPlot(:,:,3) = zeros(size(O3));
X = SynthModelData.Lat(Month,:,:);
X = reshape(X, size(X,2), size(X,3));
Y = SynthModelData.Lon(Month,:,:);
Y = reshape(Y, size(Y,2), size(Y,3));
surf(X, Y, O3,...
ColsPlot, 'FaceAlpha',0.6)
hold on

% show variations
for idx=1:size(SynthModelData.Ozone,1)
    O3 = SynthModelData.Ozone(idx,1,:,:);
    O3 = reshape(O3, size(O3,3), size(O3,3));
    ColsPlot(:,:,1) = repmat( Cols(idx,1), size(O3) );
    ColsPlot(:,:,2) = repmat( Cols(idx,2), size(O3) );
    ColsPlot(:,:,3) = repmat( Cols(idx,3), size(O3) );
    X = SynthModelData.Lat(Month,:,:);
    X = reshape( X, size(X,2), size(X,3) );
    Y = SynthModelData.Lon( Month,:,: );
    Y = reshape( Y, size(Y,2), size(Y,3) );
    surf(X, Y, O3, ColsPlot, 'FaceAlpha',0.6)
    
    hold on
end

end

