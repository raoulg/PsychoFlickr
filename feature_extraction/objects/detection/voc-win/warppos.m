function warped = warppos(model, pos)

% warped = warppos(name, model, pos)
% Warp positive examples to fit model dimensions.
% Used for training root filters from positive bounding boxes.

globals;

fi = model.symbols(model.rules{model.start}.rhs).filter;
fsize = model.filters(fi).size;
pixels = fsize * model.sbin;
heights = [pos(:).y2]' - [pos(:).y1]' + 1;
widths = [pos(:).x2]' - [pos(:).x1]' + 1;
numpos = length(pos);
warped = cell(numpos);
cropsize = (fsize+2) * model.sbin;
for i = 1:numpos
  fprintf('%s: warp: %d/%d\n', model.class, i, numpos);
  im = imreadx(pos(i));
  padx = model.sbin * widths(i) / pixels(2);
  pady = model.sbin * heights(i) / pixels(1);
  x1 = round(pos(i).x1-padx);
  x2 = round(pos(i).x2+padx);
  y1 = round(pos(i).y1-pady);
  y2 = round(pos(i).y2+pady);
  window = subarray(im, y1, y2, x1, x2, 1);
  warped{i} = imresize(window, cropsize, 'bilinear');
end
