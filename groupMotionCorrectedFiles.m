function [] = groupMotionCorrectedFiles(dirPath,regExp, group)

fileList = dir(fullfile(dirPath, regExp)) ;

sizeFiles = size(fileList) ; 
numFiles = sizeFiles(1, 1) ;
%%
for i = 1:group:numFiles
    if i+group-1 <= numFiles
        toGroup = fileList(i:i+group-1); 
        concatenateFilesToh5_32bit(toGroup, strcat(num2str(i), '_', num2str(i+4), '_motion*corrected', '.h5'))
    else 
        toGroup = fileList(i:numFiles);
        concatenateFilesToh5_32bit(toGroup, strcat(num2str(i), '_', num2str(numFiles), '_motion*corrected','.h5'))
    end
end

end

