function GrammSmidt(b, a) = b-(a*b)/(b*b)*a;

function ort(a) = a/sqrt(a*a);

function ext(v,a) = [for(i=v) i, a];

function rotAs(a, b) = let (x =ort(a), y=ort(GrammSmidt(b, a))) [ext(x,0), ext(y,0), ext(cross(x,y),0), [0,0,0,1]];