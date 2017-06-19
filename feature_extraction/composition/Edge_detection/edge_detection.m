function [ perc_edge ] = edge_detection( immagine )
%EDGE_DETECTION: funzione per il calcolo della percentuale dei pixel
%appartenenti agli edge in un'immagine
%
%INPUT: immagine=immagine da elaborare
%OUTPUT: perc_edge= percentuale degli edge normalizzata
  
hedge = vision.EdgeDetector('Method','Canny','NonEdgePixelsPercentage',92);
hcsc = vision.ColorSpaceConverter('Conversion', 'RGB to intensity');
hidtypeconv =vision.ImageDataTypeConverter('OutputDataType','single');

img = step(hcsc, immagine);
img1 = step(hidtypeconv, img);
edges = step(hedge, img1);
 
 
perc_edge=(sum(sum(edges))/(size(edges,1)*size(edges,2)))*100;

end

