function [status] = fnRunNormcorrSession(pathToRecordings, gSig)
% run caiman normcorr matlab function on a recording session directory

fileList = dir(fullfile(pathToRecordings, '*converted.tif'));
sizeFiles = size(fileList); 
numFiles = sizeFiles(1, 1); 

for i = 1:numFiles
    
    quest_run_normcorr(fileList(i,1).folder, fileList(i,1).name, gSig); 
    
end 

status=true; 

end

