# patch2stl

This function generates an stl file from Matlab variables X, Y, and Z that define a surface patch. 
In addition, some intermediate functions are available to allow the user to customize an algorithm 
for cases not considered in this repository.

The basic idea of this function is that the surface is defined by a grid of points represented by  
variables X, Y, and Z. Z must be a matrix with a square grid of points, while X and Y may be scalars, 
vectors, or matrices. Then, each set of four neighbouring points in the square grid (i.e., four vertices
of a square) that approximate the surface is divided into two triangles. 

This function is based upon `surf2stl` developed by McDonald (2004). 

## Usage

First, download or clone the patch2stl folder in your computer. Then, add the folder into Matlab's path
by going to Home, clicking in "Set Path", and then in "Add Folder ...". In the dialog box go to and 
select the patch2stl folder.

The general usage is:

```Matlab
patch2stl('filename',X,Y,Z) 
```
When X and Y and are matrices the same size of Z, then a point in the surface patch is given by 
[X(i,j) Y(i,j) Z(i,j)], where 1 <= i <= m and 1 <= j <= n and [m,n] = size(Z). 

When X and Y are vectors, they must have length(x) = n and length(y) = m, where [m,n] = size(Z). 
Note that x corresponds to the columns of Z and y corresponds to the rows.

When X and Y are scalars, then they indicate the x and y spacing between grid points.

The stl file may be written in ascii or binary format using: 

```Matlab
patch2stl(...,mode)
```
where the value of `mode` may be one of the following:

'binary' - writes in STL binary format (default)

'ascii'  - writes in STL ASCII format

By default, if `mode` is ommited, the stl is written in binary format. 

## Customizing a function to write an stl

Intermediate function are available in the same folder (patch2stl). This allows the user to create
customized versions of an stl converter. This is useful if the user already knows or can calculate
the vertices of each triangle in a surface patch. 
To do so, just follow this template:

```Matlab

% This function opens a file with a given filename and file format (mode)
fid = patch2stl_openfile(filename, mode);

% This function generates the initial lines on the stl file
patch2stl_header(filename, fid, mode)

% Insert here the code where each triangle in the stl file is generated 
% and/or saved in the stl file
%
% First, initialize a variable to store the number of tirangles (or facets) 
% in the st file: 
nfacets = 0;

% Then, for every set of triangle vertices (p1, p2, p3) with normal vector n
% use the following line:
nfacets = nfacets + patch2stl_facet_wr(fid, p1, p2, p3, n, mode);
%
% Function patch2stl_facet_wr writes a single triangle into the stl file. 
% The output of function patch2stl_facet_wr is 1 if the triangle was succesfully
% written, or 0 other wise. This is why its output is accumulated into variable
% nfacets. 
% The total number of triangles (or facets) is needed when writing the ending 
% lines of the stl file.

% This function generates the ending lines on the stl file and closes the file
% NOTE: It is necessary to update the fid variable for Matlab to close the file
fid = patch2stl_footer(fid, nfacets, mode);
```

## References

Bill McDonald (2004). surf2stl (https://www.mathworks.com/matlabcentral/fileexchange/4512-surf2stl), MATLAB Central File Exchange. Retrieved July 18, 2024. 