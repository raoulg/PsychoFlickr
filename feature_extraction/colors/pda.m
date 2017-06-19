function [p d a]= pda(immagine)
%%  Valori di pleasure, dominance e arousal dell'immagine 
% 
% data un'immagine vengono calcolati i valori di piacere, dominanza ed
% eccitazione che essa suscita, a seconda dei valori di saturazione e
% luminosità, come descritto in "Affective Image Classification using Features Inspired by
% Psychology and Art Theory" di Jana Machajdik e Allan Hanbury


x=immagine;        

%ricavo i valori di tonalità e saturazione
[h s b]=rgb2hsv(x);

pleasure=0.69*b(:)+0.22*s(:);
p= mean(pleasure);

arousal=-0.31*b(:)+0.60*s(:);
a=mean(arousal);

dominance=-0.76*b(:)+0.32*s(:);
d=mean(dominance);
return