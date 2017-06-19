function [Is] = rgb2ihls(I)
% Converts an image to IHLS color space
%
% INPUT
%    I  : image to convert (in RGB)
%
% OUTPUT
%    Is : output image (in IHLS)

%% Error checking
if size(I,3) == 1
    error('We need a color image here!');
end

%% Computations
Is = zeros(size(I));  % output image
R = double(I(:,:,1)); % red channel
G = double(I(:,:,2)); % green channel
B = double(I(:,:,3)); % blue channel

% Hue
% NOTE: HUE IS IN RADIANS !!
theta = acos((R-0.5*G-0.5*B)./sqrt(R.^2 + G.^2 + B.^2 -R.*G - R.*B -B.*G));

p1 = find(B <= G);
p2 = find(B > G);

Is(p1) = theta(p1);
Is(p2) = 2*pi - theta(p2);

% Saturation
Is(:,:,3) = max(max(R,G),B) - min(min(R,G),B);

% Luminance
Is(:,:,2) = 0.210*R + 0.715*G + 0.072*B;

end
