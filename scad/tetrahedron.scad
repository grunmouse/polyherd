use <functions.scad>
module tetrahedron(a=1,center=false){
    points=[
        [0,0,0],
        [1,0,0],
        [0.5,sin(60),0],
        [0.5,0.5*tan(30),sqrt(2/3)]
    ];
    faces=[
        [0,1,2],
        [2,1,3],
        [1,0,3],
        [0,2,3]
    ];
    doPoly(points, faces, a, center);
}
    
