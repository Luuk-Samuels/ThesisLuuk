function [t,x,y] = track_dot(vid,px2m)
%% 0.Initialize
col = 3; %blue
V   = VideoReader(vid);
nF  = V.NumberOfFrames;
t   = linspace(0,V.Duration,nF)';
x   = nan(nF,1);
y   = nan(nF,1);
test = nan(nF,1);
%% 1. Loop video frames
for i=2:nF %2:10:nF
    %Extract blue color and convert to binary (black and white)
    im_temp1 = read(V,i);
    im_temp = imsubtract(im_temp1(:,:,col),rgb2gray(im_temp1));
    test(i) = sum(sum(im_temp))/(size(im_temp,1)*size(im_temp,2));
    im_temp = medfilt2(im_temp,[3,3]); 
        
    im_temp = imbinarize(im_temp,0.12);   %straight
    %im_temp = imbinarize(im_temp,0.05); %circular
    im_temp = bwareaopen(im_temp,1);
    %Get connected regions and extract properties
    im_prop = regionprops(logical(im_temp),'BoundingBox','Centroid');
    %Sort by area if more than two regions are picked up
    if length(im_prop) > 1
        diff = nan(length(im_prop),1);
        for j = 1:length(im_prop)
            diff(j,1) = norm(im_prop(j).Centroid - [x(i-1),y(i-1)]); 
        end
        [~,sort_temp] = sort(diff);
        im_prop   = im_prop(sort_temp(1));
    end
%     Debug  
    if i == floor(1000-nF/12) || i == floor(1000-nF/12+1*nF/30) || i == floor(1000-nF/12+2*nF/30) || i == floor(1000-nF/12+3*nF/30) || i == floor(1000-nF/12+4*nF/30) || i == floor(1000-nF/12+5*nF/30)
        hold on
        imshow(im_temp1)
        
        rectangle('Position',im_prop(end).BoundingBox,'EdgeColor','r','LineWidth',2);
        hold on
        
    end
%     pause(0.1)
    if isempty(im_prop)
        fprintf('did not find object');
        x(i,1)  = x(i-1,1);
        y(i,1)  = y(i-1,1);
    else
        x(i,1)  = im_prop(end).Centroid(1);
        y(i,1)  = im_prop(end).Centroid(2);
    end
    fprintf('Analysing frame %d of %d\n',i,nF);
end

%% 2. Convert to meters and convert to displacement
x0 = x(~isnan(x));
y0 = y(~isnan(y));
x = (x-x0(1))*px2m;
y = (y-y0(1))*px2m;

end