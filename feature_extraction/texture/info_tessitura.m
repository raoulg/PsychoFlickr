function [ analisi_texture ] = info_tessitura( img )
%INFO_TESSITURA Utilizzo di mtext per il calcolo di informazioni sulla
%presenza di tessitura in un'immagine
%
%INPUT: img:immagine
%OUTPUTS: entropia: entropia dell'immagine
%        analisi_texture: indice di texture

%% ATTENZIONE: E' necessario installare mtex eseguendo startup_mtex nella cartella mtex

cd mtex
%Creo il modello ods
gray = rgb2gray(img);
cs   = symmetry('triclinic');    % crystal symmetry
ss   = symmetry('triclinic');    % specimen symmetry
C = fft2(gray); % Fourier coefficients
odf = FourierODF(C,cs,ss);

analisi_texture=textureindex(odf,'fourier');


cd ..
end
