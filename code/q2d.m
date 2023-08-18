rng(0);
C = [1.6250, -1.9486; -1.9486, 3.8750];    %covariance matrix
mean = [1;2];
[eigvec,eigval] = eig(C);
root_eigval = sqrt(eigval);
rotation = eigvec*root_eigval;  %so that variance of data line with given variance
for i=1:5
    figure(i);
    N1= rotation*randn(2,10^i) + mean;    % N=10^i
    mean1=[sum(N1(1,:),'all')/10^i;sum(N1(2,:),'all')/10^i];
    m1=N1-mean1;
    C1 = m1*m1';
    [eigvec1,eigval1]=eig(C1);
    val = min(diag(eigval));
    scatter(N1(1,:),N1(2,:));
    hold on;
    quiver(mean1(1,1),mean1(2,1),eigvec(1,1),eigvec(2,1),eigval(1,1)/val,'-r','AlignVertexCenters',1);    %eigenvector in both direction
    quiver(mean1(1,1),mean1(2,1),eigvec(1,2),eigvec(2,2),eigval(2,2)/val,'-r','AlignVertexCenters',1);
    hold off;
end