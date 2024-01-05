% demo file for applying the NoRMCorre motion correction algorithm on 
% 1-photon widefield imaging data
% Example file is provided from the miniscope project page
% www.miniscope.org

clear;
gcp;
%% download data and convert to single precision
name = '/Users/johnmarshall/Documents/Analysis/MiniscopeMovies/YiwenData/normcorrTest/';
path_split = split(name, '.');
name_split = split(path_split{1,1}, '/');
size_path = size(name_split);
movie_name = name_split{size_path(1), 1};

addpath(path_split{2,1});

if ~exist(name,'file')  % download file if it doesn't exist in the directory
    url = 'https://caiman.flatironinstitute.org/~neuro/normcorre_datasets/msCam13.avi';
    fprintf('downloading the file...');
    outfilename = websave(name,url);
    fprintf('done.');
end

%addpath(genpath('../../NoRMCorre'));
Yf = read_file(name);
Yf = single(Yf);
[d1,d2,T] = size(Yf);
%% parameters

framerate = 20; 


%% perform some sort of deblurring/high pass filtering

if (0)    
    hLarge = fspecial('average', 40);
    hSmall = fspecial('average', 2); 
    for t = 1:T
        Y(:,:,t) = filter2(hSmall,Yf(:,:,t)) - filter2(hLarge, Yf(:,:,t));
    end
    %Ypc = Yf - Y;
    bound = size(hLarge,1);
else
    gSig = 7; 
    gSiz = 3*gSig; 
    psf = fspecial('gaussian', round(2*gSiz), gSig);
    ind_nonzero = (psf(:)>=max(psf(:,1)));
    psf = psf-mean(psf(ind_nonzero));
    psf(~ind_nonzero) = 0;   % only use pixels within the center disk
    %Y = imfilter(Yf,psf,'same');
    %bound = 2*ceil(gSiz/2);
    Y = imfilter(Yf,psf,'symmetric');
    bound = 0;
end
%% first try out rigid motion correction
    % exclude boundaries due to high pass filtering effects
options_r = NoRMCorreSetParms('d1',d1-bound,'d2',d2-bound,'bin_width',200,'max_shift',20,'iter',1,'correct_bidir',false,'output_type','hdf5','h5_filename',strcat(movie_name, '_motion_corrected'));

%% register using the high pass filtered data and apply shifts to original data
tic; [M1,shifts1,template1] = normcorre_batch(Y(bound/2+1:end-bound/2,bound/2+1:end-bound/2,:),options_r); toc % register filtered data
    % exclude boundaries due to high pass filtering effects
tic; Mr = apply_shifts(Yf,shifts1,options_r,bound/2,bound/2); toc % apply shifts to full dataset
    % apply shifts on the whole movie
%% compute metrics 
%[cY,mY,vY] = motion_metrics(Y(bound/2+1:end-bound/2,bound/2+1:end-bound/2,:),options_r.max_shift);
%[cYf,mYf,vYf] = motion_metrics(Yf,options_r.max_shift);

%[cM1,mM1,vM1] = motion_metrics(M1,options_r.max_shift);
%[cM1f,mM1f,vM1f] = motion_metrics(Mr,options_r.max_shift);

%% plot rigid shifts and metrics


%% now apply non-rigid motion correction
% non-rigid motion correction is likely to produce very similar results
% since there is no raster scanning effect in wide field imaging

options_nr = NoRMCorreSetParms('d1',d1-bound,'d2',d2-bound,'bin_width',50, ...
    'grid_size',[128,128]*2,'mot_uf',4,'correct_bidir',false, ...
    'overlap_pre',32,'overlap_post',32,'max_shift',20);

tic; [M2,shifts2,template2] = normcorre_batch(Y(bound/2+1:end-bound/2,bound/2+1:end-bound/2,:),options_nr,template1); toc % register filtered data
tic; Mpr = apply_shifts(Yf,shifts2,options_nr,bound/2,bound/2); toc % apply the shifts to the removed percentile

%% compute metrics

%[cM2,mM2,vM2] = motion_metrics(M2,options_nr.max_shift);
%[cM2f,mM2f,vM2f] = motion_metrics(Mpr,options_nr.max_shift);

%% plot shifts        


%% display downsampled data
% M1 is rigid corrected movie, M2 is non-rigid corrected


%%  

%% make single tiff video with filtered data for further processing




