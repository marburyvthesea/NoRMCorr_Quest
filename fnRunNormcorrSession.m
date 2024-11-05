function [status] = fnRunNormcorrSession(pathToRecordings, gSig)
% run caiman normcorr matlab function on a recording session directory

% Get files matching each pattern
convertedFiles = dir(fullfile(pathToRecordings, '*converted.tif'));
denoisedFiles = dir(fullfile(pathToRecordings, 'denoised*.tiff'));

% Combine the file lists
fileList = [convertedFiles; denoisedFiles];

sizeFiles = size(fileList); 
numFiles = sizeFiles(1, 1); 

for i = 1:numFiles
    
    quest_run_normcorr(fileList(i,1).folder, fileList(i,1).name, gSig); 
    
end 

status=true; 

end

