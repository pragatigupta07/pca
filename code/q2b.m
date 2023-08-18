C = [1.6250, -1.9486; -1.9486, 3.8750];    %covariance matrix
mean = [1;2];
[eigvec,eigval] = eig(C);
root_eigval = sqrt(eigval);
rotation = eigvec*root_eigval;  %so that variance of data line with given variance
%2D gaussian generation (a)
%N = rotation*randn(2,N) + mean;  rotation and shifting(mean)
%(b) error mean-MLE_mean
summ = zeros(5,100,2); %summation of 100 experiments for each N
for i=1:5
    for j=1:100
        summ(i,j,:)=reshape(sum(rotation*randn(2,10^i)+mean,2),1,1,2);
    end
end
%MLE mean = sum/N
for i=1:5
    summ(i,:,:)=summ(i,:,:)/10^i ;
end
error = zeros(100,5);   %error calculation
for i=1:5
    for j=1:100
        error(j,i)=norm(reshape(summ(i,j,:),1,2)-mean)/norm(mean);
    end
end
figure;
boxplot(error);
title('MLE mean error');