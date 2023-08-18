C = [1.6250, -1.9486; -1.9486, 3.8750];    %covariance matrix
mean = [1;2];
[eigvec,eigval] = eig(C);
root_eigval = sqrt(eigval);
rotation = eigvec*root_eigval;  %so that variance of data line with given variance
%2D gaussian generation (a)
N = 1000;
N_point = rotation*randn(2,N) + mean;  %rotation and shifting(mean)