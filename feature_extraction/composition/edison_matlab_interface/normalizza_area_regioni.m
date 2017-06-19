function [area_media_normalizzata]=normalizza_area_regioni( aree_regioni, area_Immagine)
%NORMALIZZA AREA REGIONI Calcola l'area media delle regioni normalizzata
% per l'area dell'immagine di partenza
% Esempio:
%   [area_media_normalizzata] = normalizza_area_regioni(numero_regioni, area_regioni, area_Immagine)
% 
% INPUTS:
% aree_regioni= area in pixel delle regioni
% area_Immagine= area in pixel dell' immagine di partenza
% OUTPUT:
% area_media_normalizzata= area medie delle regioni;


% Calcolo il numero di regioni:
numero_regioni=size(aree_regioni,2);

% Calcolo area media delle regioni
area_media= sum(aree_regioni)/(numero_regioni);
% Normalizzo per l'era totale dell'immagine
area_media_normalizzata= area_media/(area_Immagine);
