use <./parts.scad>

n=5;
dist=2;

translate([70.6/2 - 1.7/2,5.1+8,1])
    linear_extrude(height=5)
        rounded_rectangle(width=58, length=n*2+(n-1)*dist, r=3);

cylinder(d=53.5, h=2, center=false, $fn=100);