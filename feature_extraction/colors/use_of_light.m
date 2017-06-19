function [light]= use_of_light(immagine_elaborata)
     hsv=rgb2hsv(immagine_elaborata);
     [X,Y,Z]=size(hsv);
     v= hsv(:,:,3);
     light=mean(v(:));
%      light=(1/(X*Y))*(sum(sum(hsv(1:X,1:Y,3))));
