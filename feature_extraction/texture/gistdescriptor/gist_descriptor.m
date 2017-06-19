function [ features, param ] = gist_descriptor( img, n_scale, orientazioni)
%GIST_DESCRIPTOR 
% Calcola la trasformata Gist con un filtraggio di Gabor
% INPUTS: img: immagine
%         n_scale: numero di scale (opzionale, default=2)
%         orientazioni: vettore di orientazioni per ogni scala (opzionale, default=[4 2])
% OUTPUTS:features: vec delle immagini risultato (in media)
%         param: parametri settati e filtri generati


clear param

%param.imageSize = [256 256];
if nargin==1
    param.orientationsPerScale = [4 2];
    param.numberBlocks = 2;
else
    param.orientationsPerScale = orientazioni;
    param.numberBlocks = n_scale;
end
param.fc_prefilt = 4;

% Computing gist requires 1) prefilter image, 2) filter image and collect
% output energies
[features param] = LMgist(img, '', param);



end

