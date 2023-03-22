function [status] = fnRunNormcorrSession(pathToRecordings)
% run caiman normcorr matlab function on a recording session directory

fileList = dir(fullfile(pathToRecordings, '*converted.tif'));
sizeFiles = size(fileList); 
numFiles = sizeFiles(1, 1); 

for i = 1:numFiles
    
    quest_run_normcorr(fileList(i,1).folder, fileList(i,1).name); 
    
end 

status=true; 

end

