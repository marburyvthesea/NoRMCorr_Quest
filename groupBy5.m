
dirPath = 'F:\JJM\miniscope_data\Dock10_Cre_mouse_2_Nov_8_2022_2023_01_17_14_52_51\' ;
regExp = '*converted.tif' ;

fileList = dir(fullfile('F:\JJM\miniscope_data\Dock10_Cre_mouse_2_Nov_8_2022_2023_01_17_14_52_51\', '*converted.tif')) ;


sizeFiles = size(fileList) ; 
numFiles = sizeFiles(1, 1) ;



for i = 1:5:numFiles
    if i+4 <= numFiles
        toGroup = fileList(i:i+4); 
        concatenate_files(toGroup, strcat(dirPath, num2str(i), '_', num2str(i+4), '_motioncorrected', '.h5'), 'hdf5')
    else 
        toGroup = fileList(i:numFiles);
        concatenate_files(toGroup, strcat(dirPath, num2str(i), '_', num2str(numFiles), '_motioncorrected','.h5') ,'hdf5')
    end
end

    