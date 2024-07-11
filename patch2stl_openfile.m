function fid = patch2stl_openfile(filename, mode)
% This function opens a file to write the STL either in binary or ascii by
% using the mode variable.
% filename: string with the filename for the STL, e.g., 'gyroid.stl'
% mode: type of file, either 'ascii' or 'binary'. If not specified, mode
% defaults to binary

%Check if output format is ascii
if strcmp(mode,'ascii')
    % Open for writing in ascii mode
    fid = fopen(filename,'w');
else
    % Open for writing in binary mode
    fid = fopen(filename,'wb+');
    
    %Send message if unknown format
    if ~strcmp(mode,'binary')
        fprintf(['Unknown format: ', mode, '. File format set to binary.']);
    end
end

%Check if valid file
if (fid == -1)
    error( ['Unable to write to ',filename] );
end


end