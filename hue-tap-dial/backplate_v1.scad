use <./parts.scad>

module long_cutouts(distance=47.5,width=1.8,length=16.5, height=2.5) {
    translate([- distance/2 - width/2, - length/2, 0])
    translate([0, 0, 3.51]) {
        cube([width, length, height], center=false);

        translate([distance,0,0])
            cube([width, length, height], center=false);
    }
}

module short_cutouts(distance=43,distance_y=23,width=5,length=2, height=2.5) {
    translate([- distance/2 - width/2, -((distance_y+length)/2), 0])
        translate([0,0,3.51]) {
            {
                cube([width, length, height], center=false);

                translate([0, distance_y, 0])
                    cube([width, length, height], center=false);
            }

            translate([distance,0,0])
                {
                    cube([width, length, height], center=false);

                    translate([0, distance_y, 0])
                        cube([width, length, height], center=false);
                }
        }
}


module backplate(plate_size=53.5) {
    difference() {
        linear_extrude(height=6)
            rounded_rectangle(plate_size, plate_size, 20, fn=100);

        translate([plate_size/2 , plate_size/2, 0])
            long_cutouts();

        translate([plate_size/2 , plate_size/2, 0])
            short_cutouts();


        w1 = (plate_size - 30) / 2;
        translate([0,-0.01,4])
            cube([plate_size, w1, 5], center=false);

        translate([0,plate_size - w1 +.01,4])
            cube([plate_size, w1, 5], center=false);

        {
            translate([plate_size/2,plate_size/2,-.5]) {
                hexHole(flatToFlatDistance = M2_5(), depth=2.5);
                cylinder(d=3, h=50, center=false, $fn=100);
            }
        }

        translate([plate_size/2,plate_size/2,7.5 - 1])
            cube([15, 15, 5], center=true);

        // Magent cutouts
        translate([plate_size/2, plate_size/2-30/2, 3.51]) {
            rotate([0,0,90])
                cube([10, 20, 5], center=true);

            translate([0,30,0])
                rotate([0,0,90])
                    cube([10, 20, 5], center=true);
        }
    }
}
backplate();