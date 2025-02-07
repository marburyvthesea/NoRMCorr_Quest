function [file_path] = concatenateFilesToh5_32bit(files, filename)

% concatenate a list of files into a single file
% INPUTS
% files:        list of files as a struct array. Name of each file is in files(i).name
% filename:     output filename

% OUTPUTS

numFiles = length(files);

% Read the first file and convert to float32
Y1 = read_file(fullfile(files(1).folder, files(1).name));
Y1_32bit = single(Y1);  % Convert to float32

% File path for the HDF5 file
file_path = fullfile(files(1).folder, filename);

% Dataset name
dataset_name = '/mov';

% Get size of the data for creating the HDF5 dataset
dataSize = size(Y1_32bit);

% Create HDF5 file and write the first data set as float32
h5create(file_path, dataset_name, [dataSize(1), dataSize(2), Inf], 'Datatype', 'single', 'ChunkSize', [dataSize(1), dataSize(2), 1]);

% Write the first frame
h5write(file_path, dataset_name, Y1_32bit, [1, 1, 1], dataSize);

% Loop through the rest of the files
for i = 2:numFiles

    % Load the next file
    Yi = read_file(fullfile(files(i).folder, files(i).name));
    disp(files(i).name);
    Yi_32bit = single(Yi);  % Convert to float32

    % Get the size of the current data
    dataSize = size(Yi_32bit);

    % Get the current size of the dataset
    info = h5info(file_path, dataset_name);
    currentFrames = info.Dataspace.Size(3);

    % Write the new data, appending it to the existing dataset
    h5write(file_path, dataset_name, Yi_32bit, [1, 1, currentFrames + 1], dataSize);
end

end
