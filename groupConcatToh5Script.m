
for i = 1:group:numFiles
    if i+group-1 <= numFiles
        toGroup = fileList(i:i+group-1); 
        concatenateFilesToh5_32bit(toGroup, strcat(num2str(i), '_', num2str(i+4), '_motioncorrected', '.h5'))
    else 
        toGroup = fileList(i:numFiles);
        concatenateFilesToh5_32bit(toGroup, strcat(num2str(i), '_', num2str(numFiles), '_motioncorrected','.h5'))
    end
end