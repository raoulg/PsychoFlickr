function[en]=entropia(im)
%Non c'è bisogno di fare il check dei bin dell'istogramma per l'entropia,
%sono sempre 256;
    [R,C,channels]=size(im);
    if channels==3
    im = rgb2gray(im);
    end
    im_en = entropyfilt(uint8(im));
    en = sum(im_en(:))/(R*C);
end