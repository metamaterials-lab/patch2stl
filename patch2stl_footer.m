function fid = patch2stl_footer(fid, nfacets, mode)
% This function writes the closing lines of the STL file. 
% The file is also closed for writing within Matlab.
% The fid (file ID) variable is set as output to update the file status as
% closed when this function is called.

%Check output format to write final lines of file
if strcmp(mode,'ascii')
    fprintf(fid,'endsolid %s\r\n',title_str);
else
    fseek(fid, 0, 'bof');
    fseek(fid, 80, 'bof');
    fwrite(fid, nfacets, 'int32');
end

%Close file
fclose(fid);


end