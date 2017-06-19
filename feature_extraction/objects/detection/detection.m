function [ vettore] = detection( im )
% PEOPLE_DETECTION: 
% Dato una immagine in input ritorna il numero di persone/oggetti
% e la grandezza media normalizzata dei bounding box


%INPUT im= immagine RGB
%OUTPUT vettore= vettore che contiene il numero di oggetti corrispondenti trovati e l'area della relativa Bounding Box


vettore = zeros(28,1);

modelli{1}='VOC2009/person_final.mat';
modelli{2}='VOC2009/aeroplane_final.mat';
modelli{3}='VOC2009/bicycle_final.mat';
modelli{4}='VOC2009/bird_final.mat';
modelli{5}='VOC2009/boat_final.mat';  % non li trova nel dataset
modelli{6}='VOC2009/bottle_final.mat';
modelli{7}='VOC2009/bus_final.mat';
modelli{8}='VOC2009/car_final.mat';
modelli{9}='VOC2009/cat_final.mat';
modelli{10}='VOC2009/dog_final.mat';
modelli{11}='VOC2009/diningtable_final.mat'; % non li trova nel dataset
modelli{12}='VOC2009/horse_final.mat';
modelli{13}='VOC2009/motorbike_final.mat';
modelli{14}='VOC2009/chair_final.mat';

%Riduco l'immagine
im=imresize(im,[256 256]);

cd voc

for i=2:2:28
    load(modelli{(i/2)});
    bbox = process(im, model,-0.6);

    %Stampa
    %figure
    %showboxes(im, bbox);
    %title(modelli{(i/2)});

    numero = size(bbox,1);
    if numero == 0
        vettore(i)=0;
    else
        vettore(i) = mean(sqrt((bbox(1:end,3)-bbox(1:end,1)).*(bbox(1:end,4)-bbox(1:end,2))));
        vettore(i) = vettore(i)/(size(im,1)*size(im,2));
        vettore(i) = vettore(i)*100;
    end
    vettore(i-1)=numero;
end


cd ..


end

