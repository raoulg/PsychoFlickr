function [c] = colorfulness(A)

%A = RGB2Luv(A);
cform  =  makecform('srgb2lab');
A    =  applycform(A, cform);

%luvim = RGB2Luv(im)

numpixels = size(A,1)*size(A,2);
data = reshape(double(A)./255,numpixels,3);
edgec=[-0.5    0.2500    0.5000    0.7500    1.5];


[count edges mid loc] = histcn(data, edgec,edgec,edgec);

 Co = reshape(count,64,1);
 Co=Co./sum(Co);
 U = ones(64,1).*round(numpixels/64);
 U=U./sum(U);
 
 addpath('./emd/');
[x, c] = emd([1:64]', [1:64]', Co, U, @gdf);
%c=c/numpixels;

% % Results
% wtext = sprintf('c = %f', c);
% figure('Name', wtext);
% subplot(121);imshow(A);title('first image');
% subplot(122);imshow(B);title('second image');
