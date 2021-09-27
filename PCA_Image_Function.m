function [PCA_W,XX,V] = PCA_Image_Function(A)
%% Image compression using PCA

% SLectured by Sujin Jang in ECE662 2014 Spring, Purdue University
% Refer to "Principal Component Analysis", lecture note on
% May 2009, M. Richardson (http://people.maths.ox.ac.uk/richardsonm/SignalProcPCA.pdf)
% for detailed description and original Matlab code.

close all; 
clc;

%% Image Processing

[fly, map] = imread(A); % load image into MATLAB
fly = fly - min(fly,[],'all') / ( max(fly,[],'all') - min(fly,[],'all'));
figure;
colormap('gray');
fly = rgb2gray(fly);
fly = double(fly); % convert to double precision
image(fly);
axis off, axis equal

%% Mean | Covariance

[m, n]=size(fly);
mn = mean(fly,2); % compute row mean
X = fly - repmat(mn,1,n); % subtract row mean to obtain X
figure;
colormap('gray'),
image(X)
axis off, axis equal
% Z=1/sqrt(n-1)*X'; % create matrix, Z
% covZ=Z'*Z; % covariance matrix of Z
sigma = X * X' / size(X, 2);
%% Singular value decomposition

[U,S,V] = svd(sigma);
variances = sqrt(diag(S) .* diag(S)); % compute variances
figure;
bar(variances(1:30)) % scree plot of variances
title('Eigenvalues', 'FontSize',15);
xlabel('Order','FontSize',15); ylabel('Eigenvalue', 'FontSize',15);



%% PCA Whitening
epsilon = 0.00005;
% PCA_W = sqrt(S)/V';
PCA_W = diag(1./sqrt(diag(S) + epsilon)) * U' * X;

%% Extract first 20 principal components

nEigs = 1:1:2;
for iter=1:size(nEigs,2)
PCs = nEigs(iter);

VV = V(:,PCs:end);
Y = VV'*X; % project data onto PCs
ratio = 256/(2*PCs+1); % compression ratio
XX = VV*Y; % convert back to original basis
XX = XX+repmat(mn,1,n); % add the row means back on
figure;
image(XX);
colormap('gray');
axis off; % display results
end

%% Plot Low Ranked PC
figure
hold on;
g = n - 1;
feather(PCA_W(:,g:end),'r')
% feather(PCA_W(:,(g -10):g),'b');

