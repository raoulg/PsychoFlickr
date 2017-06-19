%%GLCM per misurare le texture. Dalle medie si calcolano il contrasto,
%%correlazione, energia e omogeneità dell'immagine.
function stats= greylev(x)
    stats=[];
    im=rgb2hsv(x);
    for i=1:3
        glcm = graycomatrix(im(:,:,i));
        stat = graycoprops(glcm);
        if isnan(stat.Contrast)
            stat.Contrast=0;
        elseif isnan( stat.Correlation);
             stat.Correlation=0;
        elseif isnan(stat.Energy)
            stat.Energy=0;
        elseif isnan(stat.Homogeneity)
            stat.Homogeneity=0;
        end
        stats(1+4*(i-1):4+4*(i-1))=[stat.Contrast; stat.Correlation; stat.Energy; stat.Homogeneity];
    end
    stats=stats';
end
