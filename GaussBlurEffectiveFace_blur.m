%一种度量人脸图像模糊程度的方法
clear all
clc
close all;
ImagePath = '../images/';
ImageList = dir(strcat(ImagePath,'*.jpg'));
ImageNum = length(ImageList);
A = [];
if ImageNum > 0
    for i =1 :ImageNum
        ImageName = ImageList(i).name;
        P0 = imread(strcat(ImagePath,ImageName));
        [M,N,~]=size(P0);
%       P0 = imresize(P0,[300,300],'bilinear');
%       imwrite(P0,[ImagePath,ImageName]);
%       imshow(P0)
%       P = imhist(P);
        P = rgb2gray(P0);
        w=fspecial('gaussian',[3,3],1);%sigma = 1
        P1 = imfilter(P,w);
        FP = fft2(P);
        FP1= fft2(P1);
        F = log(1+abs(fftshift(FP)));
        F1 = log(1+abs(fftshift(FP1)));
        H = sum(sum(F));
        H1 = sum(sum(F1));
        X = log((H-H1));
        fprintf('the image %s 高斯模糊影响因子是%f\n',ImageName,X)
        gauss_result = [A,X];
        A = gauss_result;
    end
end

hist(A,100);
title('图像的高斯模糊影响因子的得分')
xlabel('高斯模糊影响因子')
ylabel('图像数量')
 
 
 
 
