%% EXTRACTION FEATURES v2.0
% This script performs the extraction of the created dataset features

clear all
close all
clc
% Folders of images - each user has one folder
folders=dir('~/conAi/imgbasedtest/');
folders={folders.name};
folders=setdiff(folders,{'.','..','.DS_Store'})';
num=length(folders);
%%
% Instantiating the value matrix containing the computed features
data=[];
photonames = [];
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
  path_utente= ['~/conAi/imgbasedtest/' tline '/'];
  photo_list = dir([path_utente '/*.jpg']);
  %%Read user photos
  for i=1:length(photo_list)
   % read the picture
       tic
       clc
     
      fprintf('features user %d  %s num %d \n',j,tline, i);

      %%  Extraction Features
      data = [];
      toc
      %% Update the label vector
      labels = [labels utente];
      
  end
  photonames = [photonames {photo_list.name}];   
  save('names.mat','data','labels', 'photonames');
 %  read a new user
end  