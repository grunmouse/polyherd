function getCenter(center, points) = center ? -add(points)/len(points) : [0,0,0];

function add(v, i = 0, r) = 
    i < len(v) ? 
        i == 0 ?
            add(v, 1, v[0]) :
            add(v, i + 1, r + v[i]) :
        r;
        
module doPoly(points, faces, a, center){
    translate(getCenter(center, points))
    polyhedron(points*a, faces);
}