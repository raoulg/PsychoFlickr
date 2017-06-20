function [ perc_edge ] = edge_detection( immagine )
%EDGE_DETECTION: funzione per il calcolo della percentuale dei pixel
%appartenenti agli edge in un'immagine
%
%INPUT: immagine=immagine da elaborare
%OUTPUT: perc_edge= percentuale degli edge normalizzata

img = rgb2gray(immagine);
img1 = im2single(img);
edges = edge(img1,'Canny');
       
perc_edge=(sum(sum(edges))/(size(edges,1)*size(edges,2)))*100;

end

