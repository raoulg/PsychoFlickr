function showboxes(im, boxes, out)

% showboxes(im, boxes, out)
% Draw bounding boxes on top of image.
% If out is given, a pdf of the image is generated (requires export_fig).

if nargin > 2
  % different settings for producing pdfs
  print = true;
  wwidth = 2.25;
  cwidth = 1.25;
  imsz = size(im);
  % resize so that the image is 300 pixels per inch
  % and 1.2 inches tall
  scale = 1.2 / (imsz(1)/300);
  im = imresize(im, scale, 'method', 'cubic');
  %f = fspecial('gaussian', [3 3], 0.5);
  %im = imfilter(im, f);
  boxes = (boxes-1)*scale+1;
else
  print = false;
  cwidth = 2;
end

image(im); 
if print
  truesize(gcf);
end
axis image;
axis off;
set(gcf, 'Color', 'white');

if ~isempty(boxes)
  numfilters = floor(size(boxes, 2)/4);
  if print
    % if printing, increase the contrast around the boxes
    % by printing a white box under each color box
    for i = 1:numfilters
      x1 = boxes(:,1+(i-1)*4);
      y1 = boxes(:,2+(i-1)*4);
      x2 = boxes(:,3+(i-1)*4);
      y2 = boxes(:,4+(i-1)*4);
      % remove unused filters
      del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
      x1(del) = [];
      x2(del) = [];
      y1(del) = [];
      y2(del) = [];
      if i == 1
        w = wwidth;
      else
        w = wwidth;
      end
      line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', 'w', 'linewidth', w);
    end
  end
  % draw the boxes with the detection window on top (reverse order)
  for i = numfilters:-1:1
    x1 = boxes(:,1+(i-1)*4);
    y1 = boxes(:,2+(i-1)*4);
    x2 = boxes(:,3+(i-1)*4);
    y2 = boxes(:,4+(i-1)*4);
    % remove unused filters
    del = find(((x1 == 0) .* (x2 == 0) .* (y1 == 0) .* (y2 == 0)) == 1);
    x1(del) = [];
    x2(del) = [];
    y1(del) = [];
    y2(del) = [];
    if i == 1
      c = [160/255 0 0];
      s = '-';
    else
      c = 'b';
      s = '-';
    end
    line([x1 x1 x2 x2 x1]', [y1 y2 y2 y1 y1]', 'color', c, 'linewidth', cwidth, 'linestyle', s);
  end
end

% save to pdf
if print
  % requires export_fig from http://www.mathworks.com/matlabcentral/fileexchange/23629-exportfig
  export_fig([out]);
end
