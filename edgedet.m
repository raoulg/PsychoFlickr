img = rgb2gray(immagine);
img1 = im2single(img);
edges = edge(img1,'Canny');
       
perc_edge=(sum(sum(edges))/(size(edges,1)*size(edges,2)))*100;