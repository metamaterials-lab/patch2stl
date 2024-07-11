function num = patch2stl_facet_wr(fid, p1, p2, p3, n, mode)
%This function writes a facet (triangle) to a STL file
%It outputs 0 if no triangle could be generated and writte, or 1 otherwise

%Check that the three vertices of the triangle are valid numbers, i.e.,
%they are not NAN
if any( isnan(p1) | isnan(p2) | isnan(p3) )

    %There is a NAN in the vertices of the triangle
    %Since no triangle can be generated, set the output to 0
    num = 0;
    return;
end

%Set the output to one as a triangle can be generated
num = 1;

%Check output format
if strcmp(mode,'ascii')

    %Output format is ascii, use 7-decimal precision
    
    %Write components of normal vector
    fprintf(fid,'facet normal %.7E %.7E %.7E\r\n', n(1),n(2),n(3) );

    %This line is necessary for the STL format in ascii
    fprintf(fid,'outer loop\r\n');        

    %Write vertex p1 of triangle
    fprintf(fid,'vertex %.7E %.7E %.7E\r\n', p1);

    %Write vertex p2 of triangle
    fprintf(fid,'vertex %.7E %.7E %.7E\r\n', p2);

    %Write vertex p3 of triangle
    fprintf(fid,'vertex %.7E %.7E %.7E\r\n', p3);

    %This line is necessary for the STL format in ascii
    fprintf(fid,'endloop\r\n');

    %This line is necessary for the STL format in ascii
    fprintf(fid,'endfacet\r\n');
    
else

    %Output format is binary
    
    %Write normal vector
    fwrite(fid,n,'float32');

    %Write vertex p1 of triangle
    fwrite(fid,p1,'float32');

    %Write vertex p2 of triangle
    fwrite(fid,p2,'float32');

    %Write vertex p3 of triangle
    fwrite(fid,p3,'float32');

    %This seems to be a necessary output
    fwrite(fid,0,'int16');  % unused
    
end


end