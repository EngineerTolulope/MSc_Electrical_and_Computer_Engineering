% randpts.m
% Author: Shriram Tallam Puranam Raghu
% Student ID: 3521860
% Date Created: 09 May 2016
% Date Modified: 16 May 2016
% Description: Returns random coordinates in the common area of two
% ellipses in cartesian form.
% Input arguments:
% First two inputs are arrays providing information of the two ellipses.
% Each array contains 5 elements of the form [h,k,2a,2b,theta]. (h,k) is
% the centre of the ellipse and the length of the major and minor axes are
% 2a and 2b respectively. Note that the axis parallel to the Y-axis is
% considered minor axis and the axis parallel to the X-axis is considered
% major axis (if they were not rotated). Finally, theta is the angle by
% which the ellipse is rotated with respect to the X-axis.
% Third input is the PDF type. If points are uniform, then supply empty
% array. For gaussian, pass the array [mean1,std1,mean2,std2]. Warning:
% Gaussian method can be quite slow.
% Fourth Input is the number of coordinated needed (a pair (x,y) of
% coordinates count as one).
% Fifth input is an array containing region of interest (ROI) and
% increment values [xmin,dx,xmax,ymin,dy,ymax].
% Sixth input is a matrix which contains the points already picked; those
% values will be discarded. This option will ONLY work if the region of
% interest array remains constant, for example in cases where values are
% randomly picked in the given region iteratively. Supply empty array if
% not needed.
% First Output: Random coordinates in the overlapping
% region. It is a matrix of size n*2. Note that output is limited by the
% resolution of the input.
% Output is an empty array if:
% ->If there is no overlapping region.
% ->If the number of points possible are less than desired number.
% ->If there are no points left to pick.
% Second output: The mask containing the location of already picked values.
% This mask can be saved and supplied to the function to pick values that
% are not already picked. The mask is automatically updated to include past
% and current values.


function [pts_mask,pts]=randpts(arr1,arr2,distparams,numpts,ROI,pickedmask)
%Extract parameters and put them in variables.
h1=arr1(1);
k1=arr1(2);
len_maj1=arr1(3);
len_min1=arr1(4);
theta1=arr1(5);
h2=arr2(1);
k2=arr2(2);
len_maj2=arr2(3);
len_min2=arr2(4);
theta2=arr2(5);
x=ROI(1):ROI(2):ROI(3);
y=ROI(4):ROI(5):ROI(6);
%error margin. This is required as our region of interest is quantised.
errmarg=mean([ROI(2)/2,ROI(5)/2])/10;
%Create the plane of interest.
[X,Y]=meshgrid(x,y);
%Deal with a=0 and/or b=0 condition. If one of them is zero, then the
%resulting object is a line. If both are zeros, then the resulting object
%is a point at the location given by the centre of the ellipse.

%Ellipse number 1
%Circle condition or if length of both a,b are zero. Note that rotation
%does not matter here, only translation matters.
if(len_maj1==len_min1)
    r1=(len_maj1/2)^2;
    Z1=(X-h1).^2+(Y-k1).^2;
    mask1=double(abs(Z1)<=r1+errmarg);
else
    %Ellipse condition. This is just the standard form rearranged to remove
    %the terms from denominator. This is useful for situations where one of
    %the lengths is zeros.
    Z1=(len_min1/2)^2*((X-h1)*cos(theta1)+(Y-k1)*sin(theta1)).^2+(len_maj1/2)^2*((X-h1)*sin(theta1)-(Y-k1)*cos(theta1)).^2;
    mask1=double(abs(Z1)<=(len_maj1/2)^2*(len_min1/2)^2+errmarg);
    %If one of the lengths is zero, then limit the other line to the length
    %of the other axis.
    if((len_maj1==0)||(len_min1==0))
        if(len_maj1==0)
            rad=len_min1/2;
        else
            rad=len_maj1/2;
        end
        ZZ=(X-h1).^2+(Y-k1).^2;
        mask_temp=double(abs(ZZ)<=rad+errmarg);
        mask1=mask1.*mask_temp;
    end
end
%Ellipse Number 2
%Circle condition or if length of both a,b are zero. Note that rotation
%does not matter here, only translation matters.
if(len_maj2==len_min2)
    r2=(len_maj2/2)^2;
    Z2=(X-h2).^2+(Y-k2).^2;
    mask2=double(abs(Z2)<=r2+errmarg);
else
    %Ellipse condition. This is just the standard form rearranged to remove
    %the terms from denominator. This is useful for situations where one of
    %the lengths is zeros.
    Z2=(len_min2/2)^2*((X-h2)*cos(theta2)+(Y-k2)*sin(theta2)).^2+(len_maj2/2)^2*((X-h2)*sin(theta2)-(Y-k2)*cos(theta2)).^2;
    mask2=double(abs(Z2)<=(len_maj2/2)^2*(len_min2/2)^2+errmarg);
    %If one of the lengths is zero, then limit the other line to the length
    %of the other axis.
    if((len_maj2==0)||(len_min2==0))
        if(len_maj2==0)
            rad=len_min2/2;
        else
            rad=len_maj2/2;
        end
        ZZ=(X-h2).^2+(Y-k2).^2;
        mask_temp=double(abs(ZZ)<=rad+errmarg);
        mask2=mask2.*mask_temp;
    end
end
%Find common region.
mask=mask1.*mask2;
[r,c]=find(mask>0);
%Create a temporary mask for the region. Update this mask to reflect the
%values that are already picked and the values going to be picked.
mask_temp=xor(mask,not(mask));
if(isempty(r)||isempty(c))
    pts=[];
    pts_mask=[];
    return;
end
if(~isempty(pickedmask))
    mask=mask.*pickedmask;
    %Imprint previous mask if specified.
    mask_temp=mask_temp.*pickedmask;
end
[r,c]=find(mask>0);
%If no points found, then throw error.
if(isempty(r))
    pts=[];
    pts_mask=[];
    return;
end
len=length(r);
if(len<numpts)
    pts=[];
    pts_mask=[];
    return;
end
%If it has sufficient points, pass random points.
pts_temp=zeros(numpts,2);
%Uniform distribution
if(isempty(distparams))    
    randinds=randperm(len,numpts);
    pts_temp=[x(c(randinds));y(r(randinds))]';
    mask_temp(sub2ind(size(mask_temp),r(randinds),c(randinds)))=0;
else
    %Gaussian Distribution. We take advantage of the fact that range of
    %values closer to the center of the Gaussian curve have bigger range of
    %values as compared to the tail.
    sigma1=distparams(2);
    mu1=distparams(1);
    mu2=distparams(3);
    sigma2=distparams(4);
    %2 Dimensional Gaussian Distribution function, assuming independent
    %X,Y.
    %Deal with one or both axes being zero. 
    if((sigma1==0)&&(sigma2~=0))
        Z=(1/(2*pi*sigma2))*exp(-((((Y-mu2)).^2/(2*sigma2^2))));
        mask_X=double(abs(X-mu1)<=errmarg);
        Z=Z.*mask_X;
        clear mask_X;
    elseif((sigma2==0)&&(sigma1~=0))
        Z=(1/(2*pi*sigma1))*exp(-((((X-mu1)).^2/(2*sigma1^2))));
        mask_Y=double(abs(Y-mu2)<=errmarg);        
        Z=Z.*mask_Y;
        clear mask_Y;
    elseif((sigma1==0)&&(sigma2==0))
        Z=ones(size(X));
        mask_X=double(abs(X-mu1)<=errmarg);
        mask_Y=double(abs(Y-mu2)<=errmarg);
        Z=Z.*double(mask_Y).*double(mask_X);
        clear mask_X mask_Y;
    else
        Z=(1/(2*pi*sigma1*sigma2))*exp(-(((X-mu1).^2/(2*sigma1^2))+(((Y-mu2)).^2/(2*sigma2^2))));
    end
    %Use values only in the common region.
    Z=Z.*mask;
    if(length(Z(Z>0))<numpts)
        pts=[];
        pts_mask=[];
        return;
    end        
    for ii=1:numpts
        min_val=min(Z(abs(Z)>0));
        max_val=max(max(Z));
        randval=(max_val-min_val).*rand+min_val;
        [r3,c3]=find(Z>=randval);
        len=length(r3);
        ind=randperm(len,1);
        pts_temp(ii,:)=[x(c3(ind)),y(r3(ind))];
        mask_temp(r3(ind),c3(ind))=0;
        Z(r3(ind),c3(ind))=0;
    end    
end
pts=pts_temp;
pts_mask=double(mask_temp);


