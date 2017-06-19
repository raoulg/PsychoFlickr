%   Vicente Ordonez - Stony Brook University
%                     State University of New York
%
% This function calculates the low depth of field features in a similar
% fashion as suggested by Datta et al. ECCV 2006, using a wavelet transform
% and using the coefficients from the center of the image divided by
% the coefficients in the surroundings.

function feature_vector = low_depth_of_field_indicators(image)
if (size(image, 3) ~= 3)
    error('Image must be RGB color');
end
hsvimage = rgb2hsv(image);
[f1 f2 f3] = ldof_indicator(hsvimage(:, :, 1));
[f4 f5 f6] = ldof_indicator(hsvimage(:, :, 2));
[f7 f8 f9] = ldof_indicator(hsvimage(:, :, 3));
feature_vector = [f1 f2 f3 f4 f5 f6 f7 f8 f9];

    function [v1 v2 v3] = ldof_indicator(image)
        % Apply the three level wavelet transform decomposition using
        % Debauchies wave functions.
        [c s] = wavedec2(image, 3, 'db4');
        
        % Obtain the LH, HL and HH coefficients for level 3. 
        w3_lh = detcoef2('h', c, s, 3);%
        w3_hl = detcoef2('v', c, s, 3); 
        w3_hh = detcoef2('d', c, s, 3); 
        
        %figure;imshow(w3_lh, []);
 
        % Normalize coefficients.
        %w3_lh = (w3_lh - min(w3_lh(:))) ./ (max(w3_lh(:)) - min(w3_lh(:)));
        %w3_hl = (w3_hl - min(w3_hl(:))) ./ (max(w3_hl(:)) - min(w3_hl(:)));
        %w3_hh = (w3_hh - min(w3_hh(:))) ./ (max(w3_hh(:)) - min(w3_hh(:)));
        
        [height width] = size (w3_lh);
        
        % Subdivide the space into 16 regions.
        xstart = ceil(width / 4);
        ystart = floor(height / 4);
        xfinal = width - xstart;
        yfinal = height - ystart;
        
        % Take the coefficients from the 4 centered regions.
        centerweights1 = w3_lh(ystart:yfinal, xstart:xfinal);
        centerweights2 = w3_hl(ystart:yfinal, xstart:xfinal);
        centerweights3 = w3_hh(ystart:yfinal, xstart:xfinal);
        
        v1 = 0;v3 = 0;v2 = 0;
        % Sum the coefficient from the centered regions and divide by
        % all the coefficients.
        sum_w3_lh = sum(abs(w3_lh(:)));
        if (sum_w3_lh > 0)
            v1 = sum(abs(centerweights1(:))) / sum_w3_lh;
        end
        
        sum_w3_hl = sum(abs(w3_hl(:)));
        if (sum_w3_hl > 0)
            v2 = sum(abs(centerweights2(:))) / sum_w3_hl;
        end
        
        sum_w3_hh = sum(abs(w3_hh(:)));
        if (sum_w3_hh > 0)
            v3 = sum(abs(centerweights3(:))) / sum_w3_hh;
        end
        
        if(sum_w3_lh == 0)
            v1 = (v2 + v3) / 2;
        end
        
        if (sum_w3_hl == 0)
            v2 = (v1 + v3) / 2;
        end
        
        if (sum_w3_hh == 0)
            v3 = (v1 + v2) / 2;
        end
    end

end

