data = load('mnist.mat');  %load matrix file
% X stores training dataset as float (28*28,1) vector
X = cast(reshape(data.digits_train,28*28,60000),'double')';
Y = data.labels_train;
% Z a float matrix used for sum calculation with labels as its column index-1
Z = zeros(10,28*28,'double');
% W for counting occurrence of each digit in training set
W = zeros(10,1);
for i = 1:60000
    Z(Y(i,:)+1,:)=Z(Y(i,:)+1,:)+X(i,:); %increment Z with data of label corresponding to it's row index-1
    W(Y(i,:)+1,:)=W(Y(i,:)+1,:)+1 ; %increment occurrence by 1
end
% divide sum by occurrence to get mean matrix M
M = zeros(10,28*28,'double');
for i=1:10
    M(i,:)=Z(i,:)/W(i,:);
end
%imagesc(reshape(M(8,:),[28,28]));
% we have M as mean matrix and Z as sum matrix
%%%%%%%%%%%%%%%%
% C is covariance matrix
% C can be calculated as (Z'Z/W)-M'M
C = zeros(10,28*28,28*28,'double');
for i=1:10
    C(i,:,:)=(transpose(Z(i,:))*Z(i,:))/W(i,:)-transpose(M(i,:))*M(i,:);
end
%imagesc(reshape(C(7,:,:),[28*28,28*28]));
%%%%%%%%%%%%%%%%
% V eigenvector matrix
% D diagonal matrix, eigenvalues
V = zeros(28*28,28*28,10,'double');
D = zeros(28*28,28*28,10,'double');
d = zeros(28*28,10,'double');
index = zeros(28*28,10);    % to store index of sorted (descending order) eigenvalues
for i=1:10
    [V(:,:,i),D(:,:,i)]=eig(reshape(C(i,:,:),[28*28,28*28]));
    [d(:,i),index(:,i)] = sort(diag(reshape(D(:,:,i),[28*28,28*28])),'descend');
end
% principal mode of variance v1 and corresponding eigenvalue lambda1
v1 = zeros(28*28,10,'double');
lambda1 = zeros(10,1);
for i=1:10
    v1(:,i)=V(:,index(1,i),i);
    lambda1(i,1)=d(1,i);
end
%imagesc(reshape(V(:,index(4,2),2),[28,28]));
%disp(det(reshape(C(3,:,:),[28*28,28*28])));
%eigenvalue plot
figure(1);
bar(d(1,:));    %first principal component
figure(2);
bar(d(2:84,:)); %some significant components
rootlambda1=sqrt(lambda1);
%mean and eigenvector visualisation
for i=1:10
    figure(i+2)
    subplot(1,3,1)
    imagesc(reshape(M(i,:),[28,28])-reshape(v1(:,i)*rootlambda1(i,:),[28,28])); %mean - sqrt(lambda1)*principal_comp
    axis off
    subplot(1,3,2)
    imagesc(reshape(M(i,:),[28,28]));   %mean
    axis off
    subplot(1,3,3)
    imagesc(reshape(M(i,:),[28,28])+reshape(v1(:,i)*rootlambda1(i,:),[28,28])); %mean + sqrt(lambda1)*principal_comp
    axis off
end