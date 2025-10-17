use <./parts.scad>
use <./backplate_v1.scad>

plate_size=53.5;
difference() {
    backplate(plate_size);

    cube([200, 200, 3], center=true);

    translate([plate_size/2,plate_size/2,0]) {
        hexHole(flatToFlatDistance = M2_5(), depth=2.5);
        cylinder(d=3, h=60, center=false, $fn=100);
    }
}
