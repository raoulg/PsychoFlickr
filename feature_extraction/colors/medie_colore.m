

function [media_rosso media_verde media_blu]= medie_colore(immagine)
%%  MEDIA COLORE 
% Data un'immagine vengono calcolate la presenza media dei colori rosso, verde e blu
% INPUT: immagine
% OUTPUT: media_rosso: Presenza media di rosso nell'immagine
%         media_verde: Presenza media di verde nell'immagine
%         media_blu: Presenza media di blu nell'immagine

x=immagine;        

rosso=x(:,:,1);
media_rosso=mean(mean(rosso));

verde=x(:,:,2);
media_verde=mean(mean(verde));

blu=x(:,:,3);
media_blu=mean(mean(blu));


return
