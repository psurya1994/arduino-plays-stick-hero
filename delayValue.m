clear;
clc;
close all;

warning off
%% input image
% a = imread('test6.jpg');
while 1   
a = imread('http://192.168.1.100:8080/photoaf.jpg');
    % imshow(a);
    b = rgb2gray(a);
    b = imcrop(b,[370 68 408-370 395-68]);
%     imshow(b);
    % b = imresize(b,0.3);
    thres = b<45;
     thres = bwareaopen(thres,5);
    thres = imfill(thres,'holes');
    imshow(thres);

    STATS = regionprops(thres);
    a1 = STATS(1).BoundingBox;
    a2 = STATS(2).BoundingBox;

    if(a1(2)>a2(2))
    y1 = a1(2); %2nd
    y2 = a2(2)+a2(4)/2;
    else
    y1 = a1(2)+a1(4)/2; %first
    y2 = a2(2);   
    end
   

    dist = abs(y1-y2);
    disp(dist);

    %% sending serial data

    answer=1; % this is where we'll store the user's answer
    arduino=serial('COM3','BaudRate',9600); % create serial communication object on port COM4
    fopen(arduino); % initiate arduino communication
    pause(2);
    fwrite(arduino,char(dist));
    fclose(arduino); % end communication with arduino
    pause(4);
%     pause;
end