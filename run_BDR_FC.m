% Written by Canyi Lu (canyilu@gmail.com)
%
% References: 
% Canyi Lu, Jiashi Feng, Tao Mei, Zhouchen Lin and Shuicheng Yan
% Subspace Clustering by Block Diagonal Representation, 
% IEEE Transactions on Pattern Analysis and Machine Intelligence, 2019
%
% face clustering on the Extended Yale B data set
%

clear
addpath(genpath(cd));
load YaleB20run

lambda = 50
gamma = 1
rho = 0.4

% lambda = 100
% gamma = 5
% rho = 0.4 


fPCA = 0 % 0 - no PCA projection; 1 - use PCA projection
nSet = [2 3 5 8 10];
nSet = 2
fprintf('use B\n')
for i = 1:length(nSet)
    nCluster = nSet(i);
    fprintf('nCluster=%d\n',nCluster);
    idx = IndRand{nCluster};   
    tic
    for j = 1:size(idx,1)
        X = [];
        for p = 1:nCluster
            X = [X Y(:,:,idx(j,p))];
        end
        if fPCA == 1
            r = 9*nCluster;
        elseif fPCA == 0
            r = 0;
        else
            error('wrong value of r');
        end
        X = DataProjection(X,r);
        for l = 1 : size(X,2)
            X(:,l) = X(:,l)/norm(X(:,l));
        end
        [B,Z] = BDR_solver(X,nCluster,lambda,gamma);
        
        % use B
        CKSym = BuildAdjacency(thrC(B,rho));
        grps = SpectralClustering(CKSym,nCluster);
        missrateB = Misclassification(grps,s{nCluster});
        % use Z
        CKSym = BuildAdjacency(thrC(Z,rho));
        grps = SpectralClustering(CKSym,nCluster);
        missrateZ = Misclassification(grps,s{nCluster});

        AllrateB{nCluster}(j) = missrateB;   
        AllrateZ{nCluster}(j) = missrateZ;    
        fprintf('\t run %d, used B: %.3f, use Z: %.3f\n',j,missrateB,missrateZ);
    end
    times(nCluster) = toc;
    avgrateB(nCluster) = mean(AllrateB{nCluster});
    medrateB(nCluster) = median(AllrateB{nCluster});  
    stdrateB(nCluster) = std(AllrateB{nCluster});
    avgrateZ(nCluster) = mean(AllrateZ{nCluster});
    medrateZ(nCluster) = median(AllrateZ{nCluster}); 
    stdrateZ(nCluster) = std(AllrateZ{nCluster});
    times
    fprintf('use B: %.4f %.4f %.4f\n',avgrateB(nCluster),medrateB(nCluster),stdrateB(nCluster));
    fprintf('use Z: %.4f %.4f %.4f\n',avgrateZ(nCluster),medrateZ(nCluster),stdrateZ(nCluster));
    
    file = ['res_FC_nCluster=' num2str(nCluster) '_fPCA=' num2str(fPCA) '.mat'];
%     save(file,'avgrateB','avgrateZ','medrateB','medrateZ','AllrateB','AllrateZ');
end

fprintf('use B\n')

times