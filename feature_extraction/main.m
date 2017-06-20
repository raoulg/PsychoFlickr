%% EXTRACTION FEATURES v2.0
% This script performs the extraction of the created dataset features

clear all
close all
clc

% Folders of images - each user has one folder
folders=dir('~/Downloads/PsychoFlickrImages2/');
folders={folders.name};
folders=setdiff(folders,{'.','..','.DS_Store'})';
num=length(folders);
%%
% Instantiating the value matrix containing the computed features
data=[];
%  Label carrier instantiation
labels=[];
utente = 0;
% For each available user ...
for j=1:num
  utente=utente+1; 
  %% Waitbar per user
  tline = folders{j}; 
  % Create the path to read the user's photos 
  % utente is italian for user
  path_utente= ['~/Downloads/PsychoFlickrImages2/' tline '/'];
  photo_list = dir([path_utente '/*.jpg']);
  %%Read user photos
  for i=1:length(photo_list)
   % read the picture
        tic
       clc
      immagine_elaborata= imread([path_utente photo_list(i).name]);
      [rows columns numberOfColorBands] = size(immagine_elaborata); 
      if numberOfColorBands == 1
         immagine_elaborata = cat(3, immagine_elaborata, immagine_elaborata, immagine_elaborata);
      end
      fprintf('features user %d  %s num %d \n',j,tline, i);

      %%  Extraction Features
      data = [data features_immagine(immagine_elaborata)];
      toc
      %% Update the label vector
      labels= [labels utente];
  end
  save('dataset.mat','data','labels');
 %  read a new user
end

   

%% create a dataset.mat file that contains the results obtained


      
