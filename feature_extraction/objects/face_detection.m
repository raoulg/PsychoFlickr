function [ n_face, size_bounding_box ] = face_detection( immagine )
%FACE_DETECTION:
%
%INPUT: immagine: immagine RGB
%OUTPUT: n_face: numero di facce
%        size_bouding_box:  grandezza media delle bounding box

  


%% Ricerco body
% Create a detector object 
bodyDetector = vision.CascadeObjectDetector('UpperBody'); 
bodyDetector.MinSize = [60 60];
bodyDetector.ScaleFactor = 1.05;
% Read input image and detect upper body
bbox_body = step(bodyDetector, immagine);

% Draw bounding boxes
%shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]);
%I_body = step(shapeInserter, I, int32(bbox_body));
%figure, imshow(I_body);

% Create a detector object
faceDetector = vision.CascadeObjectDetector;   
bbox = step(faceDetector, immagine); 

if 0
%% Se ho trovato dei body
if size(bbox_body,1) == 0
    %% Ricerco facce
    % Detect faces
    bbox = step(faceDetector, I); 
    % Create a shape inserter object to draw bounding boxes around detections
    %shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]); 
    % Draw boxes around detected faces and display results              
    %I_faces = step(shapeInserter, I, int32(bbox));    
    %figure, imshow(I_faces), title('Detected faces');
else
    bbox_face = zeros(size(bbox_body));
    for i=1:size(bbox_body,1)
        Icrop = imcrop(I,bbox_body(i,:));
        bbox = step(faceDetector,Icrop);
        if size(bbox) == 1
            bbox_face(i,:) = bbox + [bbox_body(i,1)-1 bbox_body(i,2)-1 0 0];
        end 
    end
    bbox=bbox_face;
end
end
%shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]); 
%I_faces2 = step(shapeInserter, I, int32(bbox));
%figure, imshow(I_faces2);

if size(bbox,1) == 0 || mean(bbox(:,4)) == 0
    n_face = 0;
    size_bounding_box = 0;
else
    n_face=size(bbox,1);
    size_bounding_box=mean(bbox(:,4))/(size(immagine,1)*size(immagine,2));
end




end

