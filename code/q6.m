rng(0);
data = zeros(16,19200,'double');
for i=1:16
    txt = sprintf("image_%d.png",i);
    data(i,:)=double(reshape(imread(txt),1,19200))/255;  %reading file as matrix and reshaping the matrix to vector
end
mean=sum(data,1)/16;
C = (data'*data)/16-mean'*mean;    %covariance matrix
[eigvec,eigval]=eig(C);
[d,index]=sort(diag(eigvec),'descend'); % d is eigenvalue in descending order with corresponding column index
vec4 = [eigvec(:,index(1)),eigvec(:,index(2)),eigvec(:,index(3)),eigvec(:,index(4))];
% (a)
bar(eigvec(:,index(1:10)'));    %plot 10 eigval
figure(1);
subplot(1,5,1);
imagesc(reshape(mean,80,80,3)*255);
subplot(1,5,2);
imagesc(reshape(vec4(:,1),80,80,3)*255);
subplot(1,5,3);
imagesc(reshape(vec4(:,2),80,80,3)*255);
subplot(1,5,4);
imagesc(reshape(vec4(:,3),80,80,3)*255);
subplot(1,5,5);
imagesc(reshape(vec4(:,4),80,80,3)*255);
%(b)
%closest representation using eigenvectors and mean
close_data = (data)*vec4+[mean(1,index(1)),mean(1,index(2)),mean(1,index(3)),mean(1,index(4))]; %projection on eigenvectors+mean
data_new = close_data*vec4';    %reconstruction of image
for i=1:16
    figure(i+1);
    subplot(1,2,1);
    imagesc(reshape(data_new(i,:),[80,80,3])*255);
    subplot(1,2,2);
    imagesc(reshape(data(i,:),[80,80,3])*255);
end
%(c)
%sample generation, sample=randn(1,4)*vec4+mean
figure(18);
imagesc(reshape(randn(1,4)*vec4'+mean,80,80,30)*255);
figure(19);
imagesc(reshape(randn(1,4)*vec4'+mean,80,80,30)*255);
figure(20);
imagesc(reshape(randn(1,4)*vec4'+mean,80,80,30)*255);