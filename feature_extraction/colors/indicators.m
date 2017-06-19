function [out] = indicators(x)
hsv=rgb2hsv(x);
[X,Y,Z]=size(hsv);
out(1)=(1/(X*Y))*(sum(sum(hsv(1:X,1:Y,2))));%ave s
out(2)=std2(hsv(:,:,2));%std s
out(3)=std2(hsv(:,:,3));%std v

end