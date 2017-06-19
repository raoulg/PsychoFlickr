function wave_vector = wavelet_features(x)

if (size(x, 3) ~= 3)
    error('Image must be RGB color');
end
hsvimage = rgb2hsv(x);
wave_vector=[];

for b=1:3
    
    [c s] = wavedec2(hsvimage(:,:,b), 3, 'db4'); % decomposizione al levello i

    % Obtain the LH, HL and HH coefficients for level i. 
    [h1,v1,d1]  = detcoef2('all', c, s,1);%
    [h2,v2,d2]  = detcoef2('all', c, s,2);%
    [h3,v3,d3]  = detcoef2('all', c, s,3);%

    [hh1 wh1] = size(h1);
    [hh2 wh2] = size(h2);
    [hh3 wh3] = size(h3);

    f1 = (sum(abs(h1(:)))+sum(abs(v1(:)))+sum(abs(d1(:))))/((hh1*wh1)*3); %level 1
    f2 = (sum(abs(h2(:)))+sum(abs(v2(:)))+sum(abs(d2(:))))/((hh2*wh2)*3); %level 2
    f3 = (sum(abs(h3(:)))+sum(abs(v3(:)))+sum(abs(d3(:))))/((hh3*wh3)*3); %levle 3

    wave_vector=[wave_vector; f1; f2; f3;];
    
end

sumh = sum(wave_vector(1:3));
sums = sum(wave_vector(4:6));
sumv = sum(wave_vector(7:9));

wave_vector = [wave_vector; sumh; sums; sumv];

end