%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%START OF TRAINING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
clc;

% The folder in which your images exists
srcFiles = dir('Training Happy\*.png');
srcFiles1 = dir('Training Sad\*.png');
srcFiles2 = dir('Training Surprise\*.png');


for i = 1 : length(srcFiles)
    
%To detect Face
FDetect = vision.CascadeObjectDetector;
filename = strcat('Training Happy\',srcFiles(i).name);
I = imread(filename);
[rows columns numberOfColorChannels] = size(I);
if (numberOfColorChannels > 1)
  I = rgb2gray(I);
else
  I = I; % It's already gray.
end
BB = step(FDetect,I);
%Cropping the image to have only the face
C1=imcrop(I, BB);
filename = strcat('Croppedface Happy\',srcFiles(i).name);
imwrite(C1,filename);

%Extracting lips
pixelData = C1(sub2ind(size(C1), 1, 1));
filename = strcat('Croppedface Happy\',srcFiles(i).name);
rgbImageInfo = imfinfo(filename);
L=imcrop(C1, [0.25*rgbImageInfo.Width 0.74*rgbImageInfo.Height 0.50*rgbImageInfo.Width 0.17*rgbImageInfo.Height]);
L=imresize(L,[30 60],'bilinear');
filename = strcat('Croppedlips Happy\',srcFiles(i).name);
imwrite(L,filename);

%Extracting Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',50);
BB=step(EyeDetect,C1);
E = imcrop(C1,BB);
E=imresize(E,[30 60],'bilinear');
filename = strcat('Croppedeyes Happy\',srcFiles(i).name);
imwrite(E,filename);

end

for i = 1 : length(srcFiles1)
    
%To detect Face
FDetect = vision.CascadeObjectDetector;
filename = strcat('Training Sad\',srcFiles1(i).name);
I = imread(filename);
[rows columns numberOfColorChannels] = size(I);
if (numberOfColorChannels > 1)
  I = rgb2gray(I);
else
  I = I; % It's already gray.
end
BB = step(FDetect,I);
%Cropping the image to have only the face
C2=imcrop(I, BB);
filename = strcat('Croppedface Sad\',srcFiles1(i).name);
imwrite(C2,filename);

%Extracting lips
pixelData = C2(sub2ind(size(C2), 1, 1));
filename = strcat('Croppedface Sad\',srcFiles1(i).name);
rgbImageInfo = imfinfo(filename);
L=imcrop(C2, [0.25*rgbImageInfo.Width 0.74*rgbImageInfo.Height 0.50*rgbImageInfo.Width 0.17*rgbImageInfo.Height]);
L=imresize(L,[30 60],'bilinear');
filename = strcat('Croppedlips Sad\',srcFiles1(i).name);
imwrite(L,filename);

%Extracting Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',50);
BB=step(EyeDetect,C2);
E = imcrop(C2,BB);
E=imresize(E,[30 60],'bilinear');
filename = strcat('Croppedeyes Sad\',srcFiles1(i).name);
imwrite(E,filename);

end

for i = 1 : length(srcFiles2)
    
%To detect Face
FDetect = vision.CascadeObjectDetector;
filename = strcat('Training Surprise\',srcFiles2(i).name);
I = imread(filename);
[rows columns numberOfColorChannels] = size(I);
if (numberOfColorChannels > 1)
  I = rgb2gray(I);
else
  I = I; % It's already gray.
end
BB = step(FDetect,I);
%Cropping the image to have only the face
C3=imcrop(I, BB);
filename = strcat('Croppedface Surprise\',srcFiles2(i).name);
imwrite(C3,filename);

%Extracting lips
pixelData = C3(sub2ind(size(C3), 1, 1));
filename = strcat('Croppedface Surprise\',srcFiles2(i).name);
rgbImageInfo = imfinfo(filename);
L=imcrop(C3, [0.25*rgbImageInfo.Width 0.74*rgbImageInfo.Height 0.50*rgbImageInfo.Width 0.17*rgbImageInfo.Height]);
L=imresize(L,[30 60],'bilinear');
filename = strcat('Croppedlips Surprise\',srcFiles2(i).name);
imwrite(L,filename);

%Extracting Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig','MergeThreshold',50);
BB=step(EyeDetect,C3);
E = imcrop(C3,BB);
E=imresize(E,[30 60],'bilinear');
filename = strcat('Croppedeyes Surprise\',srcFiles2(i).name);
imwrite(E,filename);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%END OF TRAINING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

