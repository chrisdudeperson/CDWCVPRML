% Closes all figures and clears workspace and command windows
close all;
clear all;

% Set paths
DATASET_FOLDER = '/Users/chriswillis10/Documents/CVPR/MSRC_ObjCategImageDatabase_v2';
OUT_FOLDER = '/Users/chriswillis10/Documents/CVPR/descriptors';
OUT_SUBFOLDER='globalRGBhisto';


allFiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for i=1:length(allFiles)
%  for i=310:310
    fileName=allFiles(i).name;
    fprintf('Processing file %d/%d - %s\n',i,length(allFiles),fileName);
    tic;
    imgPath=([DATASET_FOLDER,'/Images/',fileName]);
    imgNorm=double(imread(imgPath));
    outputFile=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fileName(1:end-4),'.mat'];%replace .bmp with .mat
    F=gridImage(imgNorm, 8);
%     F = ComputeRGBHistogram(imgNorm,4);
    F = F./255;
    save(outputFile,'F');
    toc;
end
