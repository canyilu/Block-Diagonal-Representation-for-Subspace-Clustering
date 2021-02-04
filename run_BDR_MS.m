% Written by Canyi Lu (canyilu@gmail.com)
%
% References: 
% Canyi Lu, Jiashi Feng, Tao Mei, Zhouchen Lin and Shuicheng Yan
% Subspace Clustering by Block Diagonal Representation, 
% IEEE Transactions on Pattern Analysis and Machine Intelligence, 2019
%
% motion segmentation on the Hopkins 155 dataset
%

clear ;
addpath(genpath(cd)) ;

%% 
datadir = '.\Hopkins155\';
seqs = dir(datadir);
seq3 = seqs(3:end); % Get rid of the two directories: "." and ".."
% Save the data loaded in struct "data"
data = struct('X', {}, 'name',{}, 'ids',{});
for i=1:length(seq3)
    fname = seq3(i).name;
    fdir = [datadir '/' fname];
    if isdir(fdir)
        datai = load([fdir '/' fname '_truth.mat']);
        id = length(data)+1;        
        data(id).ids = datai.s; % the true group numbers        
        data(id).name = lower(fname); % file name
        X = reshape(permute(datai.x(1:2,:,:),[1 3 2]), 2*datai.frames, datai.points);  % X is the motion sequence
        nCluster = length( unique( data(id).ids ) ) ;
        X = [X;ones(1,size(X,2))];
        data(id).X = X;
    end
end
clear seq3;

lambda = 0.07; 
gamma = 0.007; 
rho = 0.7; 
fPCA = 0 % 0 - no projection, 1 - projection by PCA 
maxNumGroup = 5;
num = zeros(maxNumGroup,1);
for i = 1:length(data)
    X = data(i).X;
    s = data(i).ids';
    nCluster = length(unique(s));
    if nCluster == 2 || nCluster == 3    
        if fPCA == 1
            r = 4*nCluster;
        elseif fPCA == 0
            r = 0;
        else
            error('wrong value of r');
        end
        X = DataProjection(data(i).X,r);
        [B,Z] = BDR_solver(X,nCluster,lambda,gamma);
            
        % use Z
        CKSym = BuildAdjacency(thrC(Z,rho));
        grps = SpectralClustering(CKSym,nCluster);
        rateZ = Misclassification(grps,s);
        
        % use B
        CKSym = BuildAdjacency(thrC(B,rho));
        grps = SpectralClustering(CKSym,nCluster);
        rateB = Misclassification(grps,s);
        num(nCluster) = num(nCluster)+1;
        allrateZ{nCluster}(num(nCluster)) = rateZ;
        allrateB{nCluster}(num(nCluster)) = rateB;
        fprintf('seq %d\t %f, %f\n',i,rateZ,rateB);
    end
end
fprintf('\n') ;

L = [2 3];
for i = 1:length(L)
    j = L(i);
    avgrateZ(j) = mean(allrateZ{j});
    medrateZ(j) = median(allrateZ{j});
    avgrateB(j) = mean(allrateB{j});
    medrateB(j) = median(allrateB{j});
end
avgallZ = mean([allrateZ{2} allrateZ{3}]);
avgallB = mean([allrateB{2} allrateB{3}]);

medallZ = median([allrateZ{2} allrateZ{3}]);
medallB = median([allrateB{2} allrateB{3}]);

disp('BDR based on B')
disp(['  two motions, mean = ' num2str(avgrateB(2)) ', median = ' num2str(medrateB(2))])
disp(['three motions, mean = ' num2str(avgrateB(3)) ', median = ' num2str(medrateB(3))])
disp(['  all motions, mean = ' num2str(avgallB) ', median = ' num2str(medallB)])

disp('BDR based on Z')
disp(['  two motions, mean = ' num2str(avgrateZ(2)) ', median = ' num2str(medrateZ(2))])
disp(['three motions, mean = ' num2str(avgrateZ(3)) ', median = ' num2str(medrateZ(3))])
disp(['  all motions, mean = ' num2str(avgallZ) ', median = ' num2str(medallZ)])

SegmentationMethod = 'BDR';

if fPCA == 1
    savename = [ '.\Result_MS\' 'MS_' SegmentationMethod '_r=4n.mat' ];
else
    savename = [ '.\Result_MS\' 'MS_' SegmentationMethod '_r=2F.mat' ];
end

% save(savename,'allrateZ','allrateB','avgrateB','medrateB','avgallB','medallB','avgallB','avgrateZ','avgallZ','medallZ');


