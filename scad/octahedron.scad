
module octahedron(a=1, center=false){
    points = [
        [1,0,0],
        [0,1,0],
        [0,0,1],
        [-1,0,0],
        [0,-1,0],
        [0,0,-1]
    ];
    faces = [
        [0,1,2],
        [2,1,3],
        [1,0,5],
        [0,2,4],
        [4,2,3],
        [5,0,4],
        [5,4,3],
        [3,1,5]
    ];
    scale(1/sqrt(2)) 
    translate(center ? [0,0,0]: [1,1,0])
    polyhedron(points*a, faces);
}

octahedron();