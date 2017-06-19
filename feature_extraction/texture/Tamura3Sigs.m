%
% Copyright (C) 2003 Open Microscopy Environment
%       Massachusetts Institue of Technology,
%       National Institutes of Health,
%       University of Dundee
%
%
%
%    This library is free software; you can redistribute it and/or
%    modify it under the terms of the GNU Lesser General Public
%    License as published by the Free Software Foundation; either
%    version 2.1 of the License, or (at your option) any later version.
%
%    This library is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%    Lesser General Public License for more details.
%
%    You should have received a copy of the GNU Lesser General Public
%    License along with this library; if not, write to the Free Software
%    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Written by:  Nikita Orlov <norlov@nih.gov>
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% Tamura texture signatures: coarseness, directionality, contrast 
%%
%% Reference: Tamura H., Mori S., Yamawaki T., 
%% 'Textural features corresponsing to visual perception'. 
%% IEEE Trans. on Systems, Man and Cybernetics, 8, 1978, 460-472
%% 
%% Nikita Orlov
%% Computational Biology Unit, LG,NIA/NIH
%% :: revision :: 07-20-2005
%% 
%% input:   Img (input image)
%% output1: Total coarseness,       a scalar
%% output2: Coarseness histogram,   a 1x3 vector
%% output3: Directionality,         a scalar
%% output4: Contrast,               a scalar
%% 
%% Examples:
%% allTFeatures = Tamura3Sigs(Im);
%% 
function allTFeatures = Tamura3Sigs(Im)
Im=rgb2gray(Im);
if ~isa(Im,'double')
    Im = im2double(Im);
end
TM_Directionality = Tamura_Directionality(Im);
[TM_Coarseness,TM_Coarseness_hist] = Tamura_Coarseness(Im);
TM_Contrast = Tamura_Contrast(Im);
% allTFeatures = [TM_Coarseness TM_Coarseness_hist TM_Directionality TM_Contrast];
 allTFeatures = [TM_Coarseness  TM_Contrast TM_Directionality ];
% allTFeatures =  TM_Directionality ;

return;


function Fdir = Tamura_Directionality(Im)
[gx,gy] = gradient(Im); [t,r] = cart2pol(gx,gy);
good = find(r>.15.*max(r(:))); % tolgo le intensita' piccole
if isempty(good)
    Fdir=0;
else
 r=r(good); % r e t fanno riferimento solo alle intensita' grandi
 t=t(good);
Fdir = 1/(entropy(t)+1);
end


% rr=r(1:round(size(Im,1)/50):end,1:round(size(Im,2)/50):end );
% tt=t(1:round(size(Im,1)/50):end,1:round(size(Im,2)/50):end );
% good = find(r>.15.*max(r(:))); % tolgo le intensita' piccole
% r=r(good); % r e t fanno riferimento solo alle intensita' grandi
% t=t(good);
% edges = 0:pi/15:pi;
% [thisto,bin] = histc(t,edges); % calcolo l'istogramma degli angoli ossia Hd
% norma = sum(thisto);
% thisto = thisto./norma; %normalizzazione dell-istogramma
% 
% 
% bandWidth = 0.05; % MS bandwidth;
% min_size= 10; % grandezza minima del cluster che prendo in considerazione;
% [clustCent,data2cluster,cluster2dataCell] = MS_Clustering_Speed(cat(2,t,t,t),bandWidth,min_size);
% % il cat e' una bruttura, ma il codice di MS lavora cosi', su immagini...
% % faccio clustering sugli angoli.
% 
% clustCentmin= clustCent(1,:); % prendo tutti i centri eliminando le dimensioni superflue
% num_clusters = length(clustCentmin); % guardo quanti cluster ho
% for i=1:num_clusters % per ogni cluster
%     summ = 0;
%     goodt = t(data2cluster==i); % prendo tutti i theta che appartengono al cluster in iterazione
%     assbin = bin(data2cluster==i) % vedo a che bin appartengono
% %     [thisto,bin] = histc(goodt,edges); % calcolo l'istogramma degli angoli ossia Hd
%     for j=1:16 % per ogni bin
%         
%         calc = goodt(assbin==j); %elementi che stanno nel b i-esimo
%         
%         summ = summ +(calc-repmat(clustCentmin(i),thisto(j)*norma,1))*thisto(j);
%     end
%  
% end
% 
% Fdir = summ

return;


function Fc = Tamura_Contrast(Im), Im = Im(:)';
ss = std(Im); if abs(ss)<1e-10, Fc = 0;return; else, k = kurtosis(Im);end
alf = k ./ ss.^4;
Fc = ss./(alf.^(.25));
return;


function [total_coarseness,coarseness_hist] = Tamura_Coarseness(Im), 
kk = 0:6; %nh = []; nv = [];
for ii = 1:kk(end),
 A = moveav(Im,2.^(kk(ii)));
 shift = 200;
 shift = 2.^(kk(ii));
 implus = zeros(size(A)); implus(:,1:end-shift+1) = A(:,shift:end);
 iminus = zeros(size(A)); iminus(:,shift:end) = A(:,1:end-shift+1);
 Hdelta(:,:,ii) = abs(implus-iminus);
 implus = zeros(size(A)); implus(1:end-shift+1,:) = A(shift:end,:);
 iminus = zeros(size(A)); iminus(shift:end,:) = A(1:end-shift+1,:);
 Vdelta(:,:,ii) = abs(implus-iminus);
end
HdeltaMax = max(Hdelta,[],3); hs = sum(HdeltaMax(:));
VdeltaMax = max(Vdelta,[],3); vs = sum(VdeltaMax(:));
hij = reshape(Hdelta,size(Hdelta,1)*size(Hdelta,2),size(Hdelta,3)); %shij = sum(hij,1);
vij = reshape(Vdelta,size(Vdelta,1)*size(Vdelta,2),size(Vdelta,3)); %svij = sum(vij,1);
newh = zeros(size(hij,1),1); 
for ii = 1:size(hij,1),
 tmp1 = hij(ii,:); tmp2 = vij(ii,:); 
 mtmp1 = max(tmp1); mtmp2 = max(tmp2); mtmp1 = mtmp1(1); mtmp2 = mtmp2(1);
 mm = max(mtmp1,mtmp2);
 im1 = find(tmp1==mtmp1); im2 = find(tmp2==mtmp2); 
 if mm == mtmp1, imm = im1(1); else, imm = im2(1); end
 newh(ii) = kk(imm);
end
total_coarseness = mean(newh);
newh = reshape(2.^newh,size(Im,1),size(Im,2));
nbin = 3;
coarseness_hist = hist(newh(:),nbin);
coarseness_hist = coarseness_hist./max(coarseness_hist);
%coarseness_hist = uint16(coarseness_hist);
return;


function sm = moveav(Im,nk),
kern = ones(nk)./nk.^2; sm = conv2(Im,kern,'same');
return;
