function vettore = features_immagine(immagine_elaborata,i,j)

vettore = zeros(79,1); 
%% color
cd colors
% use of light, average saturatio and hue  std brightnes and saturation     
vettore(1)=use_of_light(immagine_elaborata);
vettore(2:4)=indicators(immagine_elaborata);

%pleasure dominance arousal
[p d a] = pda(immagine_elaborata);
vettore(5)=p;
vettore(6)=d;
vettore(7)=a;

%hue statistics
V = huestats(immagine_elaborata);
vettore(8)=V;

%Colorfulness is the degree of difference between a color and gray       
c=colorfulness(immagine_elaborata);
vettore(9)=c;

%colornames 
cd color_name
load('w2c.mat');
out=im2c(double(immagine_elaborata),w2c,0);
vettore(10)= sum(out==1);
vettore(11)= sum(out==2);
vettore(12)= sum(out==3);
vettore(13)= sum(out==4);
vettore(14)= sum(out==5);
vettore(15)= sum(out==6);
vettore(16)= sum(out==7);
vettore(17)= sum(out==8);
vettore(18)= sum(out==9);
vettore(19)= sum(out==10);
vettore(20)= sum(out==11);
cd ..
cd ..

%% composition
cd composition
    %Edge_Detection con Canny
    cd Edge_detection
    [ perc_edge ] = edge_detection( immagine_elaborata );
    vettore(21)= perc_edge;
    cd ..

%     if j==46 && (i==733 || i== 736)
%          vettore(22) = 0;
%         vettore(23) = 0; 
%     else
%     %Segmentazione con Edison (cfr. edison_wrapper.m)
    cd edison_matlab_interface
    [ fimage labels modes regSize ]=edison_wrapper(immagine_elaborata,@RGB2Luv);
    area_immagine= size(immagine_elaborata,1)*size(immagine_elaborata,2);
    [area_media] = normalizza_area_regioni(regSize,area_immagine);
    vettore(22) = size(regSize,2);
    vettore(23) = area_media*100; 
    cd ..
%     end

    % dof 
    dof=low_depth_of_field_indicators(immagine_elaborata);
    vettore(24)= sum(dof(1:3));
    vettore(25)= sum(dof(4:6));
    vettore(26)= sum(dof(7:9));

    %     %rule of third
    %     rt= trt(immagine_elaborata);
    %     vettore(113)=rt(2);   
    %     vettore(114)=rt(3);   
    %     
    %     %% size and aspect ratio
    %     [X,Y]=size(immagine_elaborata);
    %     vettore(115)=X+Y; 
    %     vettore(116)=X/Y;          
cd ..

%% texture
%gray dist entropy
cd texture
%vettore(4) = info_tessitura( immagine_elaborata );
vettore(27) = entropia( immagine_elaborata );

% wavelet based features v2% 
vettore(28:39)=wavelet_features(immagine_elaborata);

%tamura
vettore(40:42)=Tamura3Sigs(immagine_elaborata);

%GLCM Dalle medie si calcolano il contrasto,correlazione, energia e
%omogeneita'
stats = greylev(immagine_elaborata);
vettore(43:54)=stats;     

%Intermodalita' scena
cd gistdescriptor
[ featur, param ] = gist_descriptor( immagine_elaborata);
vettore(55:78)= featur;
cd ..
cd ..
%% objects
cd objects
%Detection di persone e oggetti
% cd detection
% [ vector_detection ] = detection( immagine_elaborata );
% vettore(79:106) = vector_detection;
% cd ..

%Face_detection
[ n_face, size_bounding_box ] = face_detection( immagine_elaborata );
% vettore(107) = n_face;
vettore(79) = size_bounding_box;
cd ..
