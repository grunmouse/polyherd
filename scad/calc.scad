function mod(a,m) = ((a%m)+m)%m;

function add(v, i = 0, r) = 
    i < len(v) ? 
        i == 0 ?
            add(v, 1, v[0]) :
            add(v, i + 1, r + v[i]) :
        r;


function Rout(n) = (1/(2*sin(180/n)));

function Rin(n) = 1/(2*tan(180/n));

function polyangle(n=3, phi=0, z=0) = 
let (r = 1/(2*sin(180/n)), al = 360/n)
[
    for(i=[0: 1: n-1]) [r*cos(i*al+phi),r*sin(i*al+phi),z]
];

function hAntiprism(n) = sqrt(pow(sin(60),2) - pow(Rout(n)-Rin(n),2));
    
function hPyramid(n) = sqrt(1 - pow(Rout(n),2));
    
function FaceCenter(points, face) = 
    let (fp = [for(i=face) points[i]])
        add(fp)/len(fp);

module pyramid(n=3){
    base = polyangle(n);
    top = [0,0, sqrt(1 - pow(Rout(n),2))];
    l = len(base);
    points = [for(b = base) b, top];
    
    faces = [
        [for(i=[0:1:l-1]) i],
        for(i=[l-1:-1:0]) [i, mod(i-1,l), l]
    ];
    
    polyhedron(points, faces);
}

module prism(n=3){
    bottom = polyangle(n);
    top = polyangle(n,z=1);
    l = len(top);
    points = [
        for(b = bottom) b,
        for(b = top) b
    ];
        
    faces = [
        [for(i=[0:1:l-1]) i],
        [for(i=[l-1:-1:0]) l+i],
        for(i=[l-1:-1:0]) let (j=mod(i-1,l)) [i, j, l+j, l+i]
    ];        
        
    polyhedron(points, faces);
}

module antiprism(n=3){
    bottom = polyangle(n);
    top = polyangle(n,phi=180/n,z=hAntiprism(n));
    l = len(top);

    points = [
        for(b = bottom) b,
        for(b = top) b
    ];
    faces = [
        [for(i=[0:1:l-1]) i],
        [for(i=[l-1:-1:0]) l+i],
        for(i=[l-1:-1:0]) let (j=mod(i-1,l)) [i, j, l+j],
        for(i=[l-1:-1:0]) let (j=mod(i-1,l)) [i, l+j, l+i]
    ];        
                
    polyhedron(points, faces);
}

module icosahedron(){
    ha = hAntiprism(5);
    hp = hPyramid(5);
    bottom = polyangle(5);
    top = polyangle(5,phi=180/5,z=ha);
    toptop = [0,0,ha+hp];
    botbot = [0,0,-hp];
    
    l=5;
    points = [
        for(b = bottom) b,
        for(b = top) b,
        toptop, botbot
    ];
    faces = [
        for(i=[l-1:-1:0]) let (j=mod(i-1,l)) [i, j, l+j],
        for(i=[l-1:-1:0]) let (j=mod(i-1,l)) [i, l+j, l+i],
        for(i=[l-1:-1:0]) [mod(i-1,l), i, 2*l+1],
        for(i=[l-1:-1:0]) [l+i, l+ mod(i-1,l), 2*l]
    ];
        
    polyhedron(points, faces);
}

module dodecahedron(){
    
    ha = hAntiprism(5);
    hp = hPyramid(5);
    bottom = polyangle(5);
    top = polyangle(5,phi=180/5,z=ha);
    toptop = [0,0,ha+hp];
    botbot = [0,0,-hp];
    
    l=5;
    
    
    ipoints = [
        for(b = bottom) b,
        for(b = top) b,
        toptop, botbot
    ];   
       
    topface = [
        for(i=[l-1:-1:0]) FaceCenter(ipoints, [l+i, l+ mod(i-1,l), 2*l])
    ];
        
    botface = [
        for(i=[l-1:-1:0]) FaceCenter(ipoints, [mod(i-1,l), i, 2*l+1])
    ];
        
    botlater = [
        for(i=[l-1:-1:0]) let (j=mod(i-1,l)) FaceCenter(ipoints,[i, j, l+j])
    ];

    toplater = [
        for(i=[l-1:-1:0]) let (j=mod(i-1,l)) FaceCenter(ipoints,[i, l+j, l+i])
    ];
      
    d = sqrt(add([for(i=toplater[0]-toplater[1]) i*i]));
    
    points = [
        for(b = botface) b,
        for(b = topface) b,
        for(b = toplater) b,
        for(b = botlater) b
    ]/d;
        
    faces = [
        [for(b=[5:1:9]) b],
        [for(b=[4:-1:0]) b],
        for(i=[0:1:4]) let (j = mod(i+1,5)) [
            5+i, 10+i, 15+i, 10+j, 5+j
        ],
        for(i=[0:1:4]) let (j = mod(i+1,5)) [
            j, 15+j, 10+j, 15+i, i
        ],
        
    ];
    
    polyhedron(points, faces);
}

dodecahedron();