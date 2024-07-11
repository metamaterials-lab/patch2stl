function [p1, p2, p3, p4] = patch2stl_vertices(i, j, x, y, z)
%This function gets the four vertices of a quadrilateral that will result
%in two triangles, it takes as reference the indices i,j
%p1 -> (i,j)
%p2 -> (i,j+1)
%p3 -> (i+1,j)
%p4 -> (i+1,j+1)
    
    %Get vertex (i,j)
    p1 = [x(i,j)  y(i,j)  z(i,j)];
    %Get vertex (i,j+1)
    p2 = [x(i,j+1)  y(i,j+1)  z(i,j+1)];
    %Get vertex (i+1,j)
    p3 = [x(i+1,j)  y(i+1,j)  z(i+1,j)];
    %Get vertex (i+1,j+1)
    p4 = [x(i+1,j+1)  y(i+1,j+1)  z(i+1,j+1)];
    
end