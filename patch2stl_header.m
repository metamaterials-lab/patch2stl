function patch2stl_header(filename, fid, mode)
% This function writes the initial lines of the STL file. These lines go
% before all the triangular facets are added.

if (fid == -1)
    error( ['Unable to write to ',filename] );
end

title_str = sprintf('Created by surf2stl.m %s', char(datetime));

%Check output format to write initial lines of file
if strcmp(mode,'ascii')
    fprintf(fid,'solid %s\r\n',title_str);
else
    str = sprintf('%-80s',title_str);    
    fwrite(fid,str,'uchar');         % Title
    fwrite(fid,0,'int32');           % Number of facets, zero for now
end


end