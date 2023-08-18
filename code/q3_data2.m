%best line fitting on dataset1
data = load('points2D_Set2.mat');
X = [data.x,data.y];
x_size = size(data.x);
mean = [sum(X(:,1),'all')/x_size(1,1), sum(X(:,2),'all')/x_size(1,1)]; 
X=X-mean;   %normalization
C = (X'*X)/x_size(1,1);  %covariance(x,y)
[eigvec,eigval]=eig(C);
[d,index]=sort(diag(eigvec),'descend'); % d eigenvalue in descending order with corresponding column index
figure(1);
scatter(X(:,1),X(:,2));
hold on;
quiver(0,0,eigvec(1,index(1))*(d(1,:)),eigvec(2,index(1))*(d(1,:)),'-r','AlignVertexCenters',1);    %plot principal eigrnvector in both direction
quiver(0,0,-eigvec(1,index(1))*(d(1,:)),-eigvec(2,index(1))*(d(1,:)),'-r','AlignVertexCenters',1);
hold off;
legend('x-y relation','principal dimension','Location','best');