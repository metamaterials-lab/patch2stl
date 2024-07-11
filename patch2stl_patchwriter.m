function nfacets = patch2stl_patchwriter(fid, x, y, z, mode)

%Initialize number of facets to be written in file
nfacets = 0;

%Get the number of rows
nr = size(z,1);
%Get the number of columns
nc = size(z,2);

%Iterate over the rows
for i=1:(nr-1)

    %Iterate over the columns
    for j=1:(nc-1)
        
        %Get the four vertices of a quadrilateral
        %p1 -> (i,j)
        %p2 -> (i,j+1)
        %p3 -> (i+1,j)
        %p4 -> (i+1,j+1)
        [p1, p2, p3, p4] = patch2stl_vertices(i, j, x, y, z);

        %Quadrilateral (p1, p2, p3, p4) is split into two triangles

        %First triangle is with indices (i,j), (i,j+1), (i+1,j+1), which is
        %equivalent to vertices p1, p2, p4, respectively
        %Calculate normal vector of that triangle
        n = normal_vec(p1,p2,p4);

        %Generate triangular facet using vertices (p1,p2,p4) and save it to 
        %file (they have to go in that order)
        val = patch2stl_facet_wr(fid, p1, p2, p4, n, mode);

        %Accumulate the number of facets generated
        nfacets = nfacets + val;

        %Second triangle is with indices (i+1,j+1), (i+1,j), (i,j), which
        %is equivalent to vertices p4, p3, p1, respectively
        %Calculate normal vector of that triangle
        n = normal_vec(p4, p3, p1);

        %Generate triangular facet using vertices (p1,2,p3) and save it to 
        %file (they have to go in that order)
        val = patch2stl_facet_wr(fid, p4, p3, p1, n, mode);

        %Accumulate the number of facets generated
        nfacets = nfacets + val;
        
    end
end


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Local subfunction

%This function calculate the normal vector
function n = normal_vec(p1,p2,p3)
    
    %Calculate vector along the edge that goes from p1 to p2
    v1 = p2-p1;

    %Calculate vector along the edge that goes from p1 to p3
    v2 = p3-p1;

    %Cross product to obtain normal vector to triangle
    v3 = cross(v1,v2);

    %Normalize normal vector
    n = v3 ./ norm(v3);

%End local function local_find_normal
end