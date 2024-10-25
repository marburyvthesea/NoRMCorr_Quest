function concatenateFilesIntoTiffs(files, filename_prefix)
    % concatenate a list of files into multipage TIFF files with 5000 frames per file
    % INPUTS:
    % files:           list of files as a struct array. Name of each file is in files(i).name
    % filename_prefix: prefix for the output TIFF files

    numFiles = length(files);
    maxFramesPerTiff = 5000;  % Maximum number of frames per TIFF
    frameCount = 0;           % Counter for frames across all files
    tiffIndex = 1;            % Counter for TIFF file number
    framesInCurrentTiff = 0;  % Counter for frames in the current TIFF

    for i = 1:numFiles
        % Load the file data
        Yi = read_file(fullfile(files(i).folder, files(i).name));
        Yi_32bit = single(Yi);  % Convert to float32
        
        % Get the number of frames in this file
        dataSize = size(Yi_32bit);
        numFramesInFile = dataSize(3);

        % Process each frame in this file
        for j = 1:numFramesInFile
            % Extract the current frame
            frame = uint16(Yi_32bit(:, :, j));  % Convert to uint16 for saving to TIFF
            
            % Check if a new TIFF file needs to be started
            if framesInCurrentTiff == 0
                % Create new TIFF filename
                tiffFilename = sprintf('%s_%d.tiff', filename_prefix, tiffIndex);
                imwrite(frame, tiffFilename, 'tiff', 'WriteMode', 'overwrite', 'Compression', 'none');
                framesInCurrentTiff = 1;
            else
                % Append frame to the current TIFF file
                imwrite(frame, tiffFilename, 'tiff', 'WriteMode', 'append', 'Compression', 'none');
                framesInCurrentTiff = framesInCurrentTiff + 1;
            end
            
            % Check if the current TIFF file has reached the maximum number of frames
            if framesInCurrentTiff >= maxFramesPerTiff
                tiffIndex = tiffIndex + 1;  % Increment TIFF file index
                framesInCurrentTiff = 0;    % Reset frame counter for new TIFF file
            end

            frameCount = frameCount + 1;  % Update total frame count
        end
    end

    fprintf('Processed %d frames into %d TIFF files.\n', frameCount, tiffIndex);
end