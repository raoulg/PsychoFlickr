

function [perc_edge]= percentuale_edge(immagine)
%% PERCENTUALE EDGE
% Calcola la percentuale di pixel di edge in un'immagine calcolata tramite il rapporto tra numero di pixel appartenenti ad edge e il numero di pixel totali
%
%INPUT: immagine=immagine da elaborare
%OUTPUT: perc_edge= percentuale di pixel appartenente ad edge

% Canny con metodo vision.EdgeDetector del toolbox Vision
hedge = vision.EdgeDetector('Method','Canny','NonEdgePixelsPercentage',92);
hcsc = vision.ColorSpaceConverter( 'Conversion', 'RGB to intensity');
hidtypeconv =vision.ImageDataTypeConverter('OutputDataType','single');
img = step(hcsc, immagine);
img1 = step(hidtypeconv, img);
edges = step(hedge, img1);

% Percentuali di pixel appartenenti ad edge 
perc_edge=(sum(sum(edges))/(size(edges,1)*size(edges,2)))*100;

