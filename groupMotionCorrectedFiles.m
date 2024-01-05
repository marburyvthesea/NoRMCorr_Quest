function [] = groupMotionCorrectedFiles(dirPath,regExp, group)

fileList = dir(fullfile(dirPath, regExp)) ;

sizeFiles = size(fileList) ; 
numFiles = sizeFiles(1, 1) ;
%%
for i = 1:group:numFiles
    if i+group-1 <= numFiles
        toGroup = fileList(i:i+group-1); 
        concatenate_files(toGroup, strcat(dirPath, num2str(i), '_', num2str(i+4), '_motioncorrected', '.h5'), 'hdf5')
    else 
        toGroup = fileList(i:numFiles);
        concatenate_files(toGroup, strcat(dirPath, num2str(i), '_', num2str(numFiles), '_motioncorrected','.h5') ,'hdf5')
    end
end

end

