% Closes all figures and clears workspace and command windows
close all;
clear all;

% Set paths
DATASET_FOLDER = '/Users/chriswillis10/Documents/CVPR/MSRC_ObjCategImageDatabase_v2';
DESCRIPTOR_FOLDER = '/Users/chriswillis10/Documents/CVPR/descriptors';
DESCRIPTOR_SUBFOLDER='globalRGBhisto';


descriptorArray=[];
fileArray=cell(1,0);
count=1;
% Acquires all files in dataset folder 
allFiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));

% Parses through each file and loads descriptors into an array
for i=1:length(allFiles)
    fileName=allFiles(i).name;
    imgPath=([DATASET_FOLDER,'/Images/',fileName]);
    descFile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fileName(1:end-4),'.mat'];%replace .bmp with .mat
    load(descFile,'F');
    fileArray{count}=imgPath;
    descriptorArray=[descriptorArray ; F];
    count=count+1;
end

% Pick an image to query
imgCount=size(descriptorArray,1);    
queryimg=floor(1*imgCount);   


% Calcuates distance between the query descriptor and all other image
% descriptors
distance=[];
for i=1:imgCount
    currentDescriptor=descriptorArray(i,:);
    queryDescriptor=descriptorArray(queryimg,:);
    currentDistance=cvpr_compare(queryDescriptor,currentDescriptor);
    distance=[distance ; [currentDistance i]];
end
distance=sortrows(distance,1);  % sort the results

%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)
resultTotal=15; % Show top 15 results
distance=distance(1:resultTotal,:);
outdisplay=[];
for i=1:size(distance,1)
   img=imread(fileArray{distance(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end
imgshow(outdisplay);
axis off;
