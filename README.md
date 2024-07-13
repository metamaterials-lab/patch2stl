# patch2stl

This function generates an stl file from Matlab variables X, Y, and Z that define a surface patch. 
In addition, some intermediate functions are available to allow the user to customize an algorithm 
for cases not considered in this repository.

The basic idea of this function is that the surface is defined by a grid of points defined by the variables X, Y, and Z. 
Then each set of four neighbouring grid points that define a squared to approximate the surface is divided into two
triangles. 

## Usage


The general usage is:

```Matlab
PATCH2STL('filename',X,Y,Z) 
```
When X and Y and are matrices the same size of Z, then a point in the surface patch is given by [X(i,j) Y(i,j) Z(i,j)], 
where 1 <= i <= m and 1 <= j <= n and [m,n] = size(Z). 

When X and Y are vectors, they must have length(x) = n and length(y) = m, where [m,n] = size(Z). 
Note that x corresponds to the columns of Z and y corresponds to the rows.

Whan X and Y are scalars, then they indicate the x and y spacing between grid points.

The stl file may be written in ascii or binary format using: 

```Matlab
PATCH2STL(...,mode)
```
where the value of `mode` may be one of the following:

'binary' - writes in STL binary format (default)
'ascii'  - writes in STL ASCII format

By default, if `mode` is ommited, the stl is written in binary format. 


