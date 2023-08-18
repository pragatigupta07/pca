C = [1.6250, -1.9486; -1.9486, 3.8750];    %covariance matrix
mean = [1;2];
[eigvec,eigval] = eig(C);
root_eigval = sqrt(eigval);
rotation = eigvec*root_eigval;  %so that variance of data line with given variance
%2D gaussian generation (a)
%N = rotation*randn(2,N) + mean;  rotation and shifting(mean)
%(c) error covariance-MLE_covariance
summ = zeros(5,100,2); %summation of 100 experiments for each N
covar = zeros(5,100,4);  %MLE covariance calculation
for i=1:5
    for j=1:100
        K = rotation*randn(2,10^i)+mean; %
        summ(i,j,:)=reshape(sum(K,2),1,1,2)/10^i;
        covar(i,j,:)=(reshape((K-reshape(summ(i,j,:),2,1))*(K-reshape(summ(i,j,:),2,1))',1,1,4))/10^i;
    end
end
error = zeros(100,5);   %error calculation
for i=1:5
    for j=1:100
        error(j,i)=norm(reshape(covar(i,j,:),2,2)-C)/norm(C);
    end
end
figure;
boxplot(error);
title('MLE covariance error');