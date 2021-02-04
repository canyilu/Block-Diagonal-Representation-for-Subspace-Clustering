function [B,Z] = BDR_solver(X,k,lambda,gamma) 

% Written by Canyi Lu (canyilu@gmail.com)
%
% References: 
% Canyi Lu, Jiashi Feng, Tao Mei, Zhouchen Lin and Shuicheng Yan
% Subspace Clustering by Block Diagonal Representation, 
% IEEE Transactions on Pattern Analysis and Machine Intelligence, 2019
%

% min_{Z,B,W} 0.5*||X-XZ||_F^2+0.5*lambda*||Z-B||_F^2+gamma*<Diag(B1)-B,W>
% s.t. diag(B)=0, B>=0, B=B^T, 
%      0<=W<=I, Tr(W)=k.


n = size(X,2);
tol = 1e-3;
maxIter = 1000; 
one = ones(n,1);
XtX = X'*X;
I = eye(n);
invXtXI = I/(XtX+lambda*I);
gammaoverlambda = gamma/lambda;
Z = zeros(n);
W = Z;
B = Z;
iter = 0;

while iter < maxIter
    iter = iter + 1;        
      
    % update Z
    Zk = Z;
    Z = invXtXI*(XtX+lambda*B);
    
    % update B
    Bk = B;
    B = Z-gammaoverlambda*(repmat(diag(W),1,n)-W);
    B = max(0,(B+B')/2);
    B = B-diag(diag(B));
    L = diag(B*one)-B;    
    
    % update W
    [V, D] = eig(L);
    D = diag(D);
    [~, ind] = sort(D);    
    W = V(:,ind(1:k))*V(:,ind(1:k))';
    
    diffZ = max(max(abs(Z-Zk)));
    diffB = max(max(abs(B-Bk)));    
    stopC = max([diffZ,diffB]);

    if stopC < tol 
        break;
    end
end


