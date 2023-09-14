%https://www.mathworks.com/matlabcentral/answers/307519-image-file-saved-using-tiff-library-tif-appear-white-in-explorer-and-paintbrush#answer_239772
tiffobj=Tiff(fToSave, 'w');
%%
setTag(tiffobj,'Photometric', Tiff.Photometric.MinIsBlack);
setTag(tiffobj, 'SampleFormat', Tiff.SampleFormat.IEEEFP);
setTag(tiffobj,'Compression', Tiff.Compression.None);
setTag(tiffobj,'BitsPerSample', 32);
setTag(tiffobj,'PlanarConfiguration', Tiff.PlanarConfiguration.Chunky);
setTag(tiffobj,'ImageLength', size(Mpr(:,:,1), 1));
setTag(tiffobj,'ImageWidth', size(Mpr(:,:,1), 2));

%%
tiffobj.write(Mpr(:,:,1), fToSave);

%%
for t = 2 : size(Mpr, 3)
    writeDirectory(tiffobj); 
    setTag(tiffobj,'Photometric',Tiff.Photometric.MinIsBlack);
    setTag(tiffobj, 'SampleFormat', Tiff.SampleFormat.IEEEFP);
    setTag(tiffobj,'Compression',Tiff.Compression.None);
    setTag(tiffobj,'BitsPerSample',32);
    setTag(tiffobj,'PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
    setTag(tiffobj,'ImageLength',size(Mpr(:,:,t), 1));
    setTag(tiffobj,'ImageWidth',size(Mpr(:,:,t), 2));
    tiffobj.write(Mpr(:,:,t), fToSave);
end

writeDirectory(tiffobj); 
setTag(tiffobj,'Photometric',Tiff.Photometric.MinIsBlack);
setTag(tiffobj, 'SampleFormat', Tiff.SampleFormat.IEEEFP);
setTag(tiffobj,'Compression',Tiff.Compression.None);
setTag(tiffobj,'BitsPerSample',32);
setTag(tiffobj,'PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
setTag(tiffobj,'ImageLength',size(Mpr(:,:,t), size(Mpr, 3)));
setTag(tiffobj,'ImageWidth',size(Mpr(:,:,size(Mpr, 3)), 2));
tiffobj.write(Mpr(:,:, size(Mpr, 3)), fToSave);