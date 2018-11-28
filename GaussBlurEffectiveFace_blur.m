%一种度量人脸图像模糊程度的方法
clear all
clc
%close all;
sharpImagePath = 'C:\Users\a1230\Desktop\挑选一些大的人脸图像\up128\';
% sharpImagePath ='C:\Users\a1230\Desktop\Face_Data\Disk\D1\';
% sharpImagePath = 'C:\Users\a1230\Desktop\Face_Data\Gaussian\G5\';
ImageList = dir(strcat(sharpImagePath,'*.png'));
ImageNum = length(ImageList);
% mkdir('C:\Users\a1230\Desktop\SVD分布\G_effect\resize_D_example\')
k  = 0;
A = []
if ImageNum > 0
    for i =1 :ImageNum% 
        ImageName = ImageList(i).name;
        
        P0 = imread(strcat(sharpImagePath,ImageName));
        [M,N,~]=size(P0);
%         P0 = imresize(P0,[300,300],'bilinear');
%         imwrite(P0,['C:\Users\a1230\Desktop\李元杰\周报\20181011工作进展\resize_for_G\resize300\',ImageName]);
%       imshow(P0)
%         P = imhist(P);
        P = rgb2gray(P0);
        w=fspecial('gaussian',[3,3],1);%sigma = 1
        P1=imfilter(P,w);
        F = fft2(P);
        F1= fft2(P1);
        %H = 
        F = log(1+abs(fftshift(F)));
        F1 = log(1+abs(fftshift(F1)));
        D = sum(sum(F));
        D1 = sum(sum(F1));
        Y = (D-D1)/(D+D1);
        X = log((D-D1));
        X1=-log(Y);
         
%         if X>10&&X<10.2%%注意这里不是一个&,而是&&
%             X
%             k = k+1
%             imwrite(P0,['C:\Users\a1230\Desktop\M0\',ImageName])
%         end
%         if X<9.4 
%             X
%             k = k+1
%             imwrite(P0,['C:\Users\a1230\Desktop\small_gaussian_effect\',ImageName]);
%         end
%         if X>9.8&&X<10
%             imwrite(P0,['C:\Users\a1230\Desktop\Med_gaussian\Med_gaussian_scores\',ImageName]);
%         end
%         fprintf('%f\n',X)
        gauss_result = [A,X];
        A = gauss_result;
%         if X<9.8
%            fprintf('the image %s 高斯模糊影响因子是%f\n',ImageName,X)
           fprintf('%f ',X)
%             continue;
%         end
    end
end


% hist(A,100);
% title('高斯模糊影响因子在resize为300*300所有人脸图像的得分')
% xlabel('高斯模糊影响因子')
% ylabel('图像数量')
 
%%
%作出不同模糊程度的高斯模糊影响因子的结果图
 
% Med_G5_score = A;
% save Med_G5_score Med_G5_score