%%hue statistics:mean, angular dispersion, saturation weighted and  without
%%saturation

function [V, meanh, Hs, Hh] = huestats(x)


%% unweighted mean direction
% ihls = rgb2ihls(x);
% H= ihls(:,:,1);
% H(find(isnan(H)))=0;
% H=H(:);
% A=sum(cos(H));
% B=sum(sin(H));
% Hh= atan(B/A);

hsvim = rgb2hsv(x);
H= hsvim(:,:,1);
H=H(:);
A=sum(cos(2*pi.*H));
B=sum(sin(2*pi.*H));
Hh= atan(B/A);

%mean h
meanh = mean(H);

%%  saturation wighted and without saturation
S=hsvim(:,:,2);
S=S(:);
As=sum(S.*cos(H));
Bs=sum(S.*sin(H));
Hs= atan(Bs/As);

%circular variance,
R= sqrt(A^2+B^2)/length(H);
V=1-R;
% Rs= sqrt(As^2+Bs^2)/length(S);

end
