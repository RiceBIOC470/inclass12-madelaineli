%Inclass 12. 
%GB comments
1) 100
2) 100
3) 100
4) 100
Overall 100

% Continue with the set of images you used for inclass 11, the same time 
% point (t = 30)

% 1. Use the channel that marks the cell nuclei. Produce an appropriately
% smoothed image with the background subtracted. 
cell = ('011917-wntDose-esi017-RI_f0016.tif');
reader = bfGetReader(cell);
slice_z = reader.getSizeZ;
chan = 2;
time = 30;
iplane = reader.getIndex(slice_z-1,chan-1,time-1)+1;
img = bfGetPlane(reader,iplane);
img_sm = imfilter(img,fspecial('gaussian',4,2));
img_bg = imopen(img_sm,strel('disk',100));
img_sm_bgsub = imsubtract(img_sm,img_bg);
figure(1)
imshow(img_sm_bgsub,[0 800]);
% 2. threshold this image to get a mask that marks the cell nuclei. 
img_bw = img_sm_bgsub>100;
figure(2)
imshow(img_bw)

% 3. Use any morphological operations you like to improve this mask (i.e.
% no holes in nuclei, no tiny fragments etc.)
figure(3)
imshow(imerode(img_bw,strel('disk',3)));

% 4. Use the mask together with the images to find the mean intensity for
% each cell nucleus in each of the two channels. Make a plot where each data point 
% represents one nucleus and these two values are plotted against each other
cellprop = regionprops(img_bw,img_sm_bgsub,'MeanIntensity','MaxIntensity','PixelValues','Area','Centroid');
intensities = [cellprop.MeanIntensity];
areas = [cellprop.Area];
figure(4)
plot(areas,intensities,'r.','MarkerSize',18);
xlabel('Areas','FontSize',28);
ylabel('Intensities','FontSize',28);

chan_2 = 1;
iplane_2 = reader.getIndex(slice_z-1,chan_2-1,time-1)+1;
img_2 = bfGetPlane(reader,iplane_2);

cellprop_2 = regionprops(img_2,img_sm_bgsub,'MeanIntensity','MaxIntensity','PixelValues','Area','Centroid');
intensities_2 = [cellprop_2.MeanIntensity];
areas_2 = [cellprop_2.Area];

figure(5)
plot(areas_2,intensities_2,'r.','MarkerSize',18);
xlabel('Areas','FontSize',28);
ylabel('Intensities','FontSize',28);
