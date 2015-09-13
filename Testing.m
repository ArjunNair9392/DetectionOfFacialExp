%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%START OF LBP HISTOGRAM AND TEMPLATE GENERATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;

%The folder in which ur images exists
srcFiles = dir('Croppedlips Happy\*.png');
srcFiles1 = dir('Croppedlips Sad\*.png');
srcFiles2 = dir('Croppedlips Surprise\*.png');

for z = 1 : length(srcFiles)
    filename = strcat('Croppedlips Happy\',srcFiles(z).name);
    I = imread(filename);
    A1 = mat2cell(I, [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]);
    filename = strcat('Croppedlips Sad\',srcFiles1(z).name);
    I = imread(filename);
    B1 = mat2cell(I, [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]);
    filename = strcat('Croppedlips Surprise\',srcFiles2(z).name);
    I = imread(filename);
    C1 = mat2cell(I, [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]);

    
for i=1:10
    for j=1:20
        a=A1{i,j}(2,2);
        b=B1{i,j}(2,2);
        c=C1{i,j}(2,2);
 
        for x=1:3
            for y=1:3
                if a >= A1{i,j}(x,y)
                    A1{i,j}(x,y)=0;
                else A1{i,j}(x,y)=1;
                end
            end
        end
        a=A1{i,j}(1,1)*2^7+ A1{i,j}(1,2)*2^6 + A1{i,j}(1,3)*2^5 + A1{i,j}(2,3)*2^4 + A1{i,j}(3,3)*2^3 + A1{i,j}(3,2)*2^2+ A1{i,j}(3,1)*2^1 + A1{i,j}(2,1)*2^0;
            
        
        for x=1:3
            for y=1:3
                if b >= B1{i,j}(x,y)
                    B1{i,j}(x,y)=0;
                else B1{i,j}(x,y)=1;
                end
             end
        end
        b=B1{i,j}(1,1)*2^7+ B1{i,j}(1,2)*2^6 + B1{i,j}(1,3)*2^5 + B1{i,j}(2,3)*2^4 + B1{i,j}(3,3)*2^3 + B1{i,j}(3,2)*2^2+ B1{i,j}(3,1)*2^1 + B1{i,j}(2,1)*2^0;
         
        for x=1:3
            for y=1:3
                if c >= C1{i,j}(x,y)
                    C1{i,j}(x,y)=0;
                else C1{i,j}(x,y)=1;
                end
            end
        end
        c=C1{i,j}(1,1)*2^7+ C1{i,j}(1,2)*2^6 + C1{i,j}(1,3)*2^5 + C1{i,j}(2,3)*2^4 + C1{i,j}(3,3)*2^3 + C1{i,j}(3,2)*2^2+ C1{i,j}(3,1)*2^1 + C1{i,j}(2,1)*2^0;
            
%ASSIGNING THE BINARY VALUES TO ALL THE CELLS
       for x=1:3
            for y=1:3
                A1{i,j}(x,y)=a;
            end
        end
        for x=1:3
            for y=1:3
                B1{i,j}(x,y)=b;
            end
        end
        for x=1:3
            for y=1:3
               C1{i,j}(x,y)=c;
            end
        end
    end
end
    
    
    IHA=cell2mat(A1);
    ISA=cell2mat(B1);
    ISU=cell2mat(C1);
    [count(z,:),x]=imhist(IHA);
    [count1(z,:),x1]=imhist(ISA);
    [count2(z,:),x2]=imhist(ISU);
    HA=[count(z,:)];
    SA=[count1(z,:)];
    SU=[count2(z,:)];
    
    if z==1
        for k=1:256
            THA(k)=0;
            TSA(k)=0;
            TSU(k)=0;
         end
    end
    for l=1:256
        TSA(l)=TSA(l)+SA(l);
        THA(l)=THA(l)+HA(l);
        TSU(l)=TSU(l)+SU(l);
    end    
end
for i=1:256
    THA(i)=THA(i)/length(srcFiles);
    TSA(i)=TSA(i)/length(srcFiles);
    TSU(i)=TSU(i)/length(srcFiles);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%END OF LBP HISTOGRAM AND TEMPLATE GENERATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%START OF LBP HISTOGRAM AND TEMPLATE MATCHING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FDetect = vision.CascadeObjectDetector;
H=imread('C:\captured.png');
[rowsxx columnsxx numberOfColorChannelsxx] = size(H);
if (numberOfColorChannelsxx > 1)
  H = rgb2gray(H);
else
  H = H; % It's already gray.
end
BB = step(FDetect,H);
%Cropping the image to have only the face
Z1=imcrop(H, BB);
filename = strcat('C:\tf.png');
imwrite(Z1,filename);
%Cropping lips of testing picture
pixelData = Z1(sub2ind(size(C1), 1, 1));
rgbImageInfo = imfinfo('C:\tf.png');
L=imcrop(Z1, [0.25*rgbImageInfo.Width 0.74*rgbImageInfo.Height 0.50*rgbImageInfo.Width 0.17*rgbImageInfo.Height]);
L=imresize(L,[30 60],'bilinear');
%imwrite(L,'Testing Croppedlips\tl.png');
H1 = mat2cell(L, [3, 3, 3, 3, 3, 3, 3, 3, 3, 3], [3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3]);
for i=1:10
    for j=1:20
        h=H1{i,j}(2,2);
        for x=1:3
            for y=1:3
                if h >= H1{i,j}(x,y)
                    H1{i,j}(x,y)=0;
                else H1{i,j}(x,y)=1;
                end
            end
        end
                h=H1{i,j}(1,1)*2^7+ H1{i,j}(1,2)*2^6 + H1{i,j}(1,3)*2^5 + H1{i,j}(2,3)*2^4 + H1{i,j}(3,3)*2^3 + H1{i,j}(3,2)*2^2+ H1{i,j}(3,1)*2^1 + H1{i,j}(2,1)*2^0;
           
        for x=1:3
            for y=1:3
                H1{i,j}(x,y)=h;
            end
        end
    end
end
H2=cell2mat(H1);
[val,op]=imhist(H2);
H3=[val];

for i=1:256
    if THA(i)==0 && H3(i)==0
        Achi(i)=0;
    else Achi(i)=((THA(i)-H3(i)).*(THA(i)-H3(i)))/(THA(i)+H3(i));
    end
    chiA=sum(Achi);
    if TSA(i)==0 && H3(i)==0
        Bchi(i)=0;
    else Bchi(i)=((TSA(i)-H3(i)).*(TSA(i)-H3(i)))/(TSA(i)+H3(i));
    end
    chiB=sum(Bchi);
    if TSU(i)==0 && H3(i)==0
        Cchi(i)=0;
    else Cchi(i)=((TSU(i)-H3(i)).*(TSU(i)-H3(i)))/(TSU(i)+H3(i));
    end
    chiC=sum(Cchi);
end
clc;
mxp=[chiA chiB chiC];
y=min(mxp)
save('C:\output.mat', 'chiA', 'chiB', 'chiC', 'mxp', 'y');
%YY='Happy face detected';
%if(chiA==y)
%    display(YY);
%end
%YY='Sad face detected';
%if(chiB==y)
%    display(YY);
%end
%YY='Surprise face detected';
%if(chiC==y)
%    display(YY);
%end
if(chiA==y)
    YY='Happy face detected'
end
if(chiB==y)
    YY='Sad face detected'
end
if(chiC==y)
    YY='Surprise face detected'
end
save('output.mat', 'YY');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%START OF LBP HISTOGRAM AND TEMPLATE MATCHING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
