function patch2stl(filename,x,y,z,mode)
%PATCH2STL   Write STL file from surface data.
%   PATCH2STL('filename',X,Y,Z) writes a stereolithography (STL) file
%   for a surface patch with geometry defined by three matrix arguments, X,
%   Y, and Z.  X, Y and Z must be two-dimensional arrays with the same size.
%
%   PATCH2STL('filename',x,y,Z), uses two vector arguments replacing
%   the first two matrix arguments, which must have length(x) = n and
%   length(y) = m where [m,n] = size(Z).  Note that x corresponds to
%   the columns of Z and y corresponds to the rows.
%
%   PATCH2STL('filename',dx,dy,Z) uses scalar values of dx and dy to
%   specify the x and y spacing between grid points.
%
%   PATCH2STL(...,'mode') may be used to specify the output format.
%
%     'binary' - writes in STL binary format (default)
%     'ascii'  - writes in STL ASCII format
%
%   Example:
%
%     patch2stl('test.stl',1,1,peaks);
%
%   See also SURF.
%

%Check the number of arguments is between the minimum and maximum expected
narginchk(4,5);

%Check that a string was input as filename
if (ischar(filename)==0)
    error( 'Invalid filename');
end

%Set the default output file format
if (nargin < 5)
    %Four input arguments, thus output format is binary
    mode = 'binary';

%Check if the mode is not ascii
elseif (strcmp(mode,'ascii')==0)
    %Mode is not ascii, so set output format as binary
    mode = 'binary';
end

%Check if z is a 2-dimensional array
if (~ismatrix(z))
    error( 'Variable z must be a 2-dimensional array' );
end

%Check if inputs x, y, z have the same size
if any( (size(x)~=size(z)) | (size(y)~=size(z)) )
    
    % size of x or y does not match size of z, so check other input options
    
    %Check if x,y are 1-dimensional vectors
    if ( (length(x)==1) & (length(y)==1) )

        % x,y must be specifying dx and dy, so make vectors
        dx = x;
        dy = y;
        x = ((1:size(z,2))-1)*dx;
        y = ((1:size(z,1))-1)*dy;
    end
        
    if ( (length(x)==size(z,2)) & (length(y)==size(z,1)) )
        % Must be specifying vectors
        xvec=x;
        yvec=y;
        [x,y]=meshgrid(xvec,yvec);
    else
        error('Unable to resolve x and y variables');
    end
        
end

%Crete file
fid = patch2stl_openfile(filename, mode);

%Write header of stl file
patch2stl_header(filename, fid, mode);

%Write patch to file
nfacets = patch2stl_patchwriter(fid, x, y, z, mode);

%Write footer of STL file and close it
fid = patch2stl_footer(fid, nfacets, mode);

%Output message with the number of facets written
fprintf('Wrote %d facets\n',nfacets);

end
