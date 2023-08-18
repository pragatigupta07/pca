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
%%%%%%%%%%%%%
% reduced dimension with max dispersion will be achieved by considering eigenvectors 
% corresponding to max 84 eigenvalues
Vk = V(:,1:84,:);
%regeneration from 84 basis
for i=1:60000
    X(i,:)=X(i,:)-M(Y(i,:)+1,:);    %normalisation
end
R = zeros(60000,84,10,'double');
for i=1:60000
    R(i,:,Y(i,:)+1)=X(i,:)*Vk(:,:,Y(i,:)+1); %projection on new basis
end
X_new = zeros(60000,28*28,10,'double');
for i=1:60000
    X_new(i,:,Y(i,:)+1)=R(i,:,Y(i,:)+1)*Vk(:,:,Y(i,:)+1)'; %reconstruction
end
sample = 35;
figure(1)
subplot(1,2,1)
imagesc(reshape(X(sample,:),[28,28]));
axis off
title("Original image sample")
subplot(1,2,2)
imagesc(reshape(X_new(sample,:,Y(sample,:)+1),[28,28]));
axis off
title(sprintf("Reconstructed"))