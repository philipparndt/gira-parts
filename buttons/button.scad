
module pyramid(bottom=20, top=10, height=7.7) {
    r1 = sqrt(2 * bottom^2) / 2;
    r2 = sqrt(2 * top^2) / 2;

    rotate([0,0,45])
        cylinder(r1 = r1, r2 = r2, h=7.7, center=false, $fn=4);

}

module case_part(width=27.4, length=55) {
    hull() {
        translate([0,10.4/2,0]) {
            translate([10.4/2,0,0])
                pyramid(bottom = 10, top=10.4, height=7.7);


            translate([length - 10.4/2,0,0])
                pyramid(bottom = 10, top=10.4, height=7.7);
        }

        // flat side
        translate([0,width-10,0]) {
            cube([10,10,7.7], center=false);

            translate([length-10,0,0])
                cube([10,10,7.7], center=false);
        }
    }
}

case_bottom_height=2.2;
module case() {
    rotate([0,0,180])
    translate([-27.4,-55/2,0]) {
        difference() {
            case_part(width=27.4, length=55);
            translate([1.4,1.4,case_bottom_height])
                case_part(width=27.4-(1.4*2)+1.5, length=55-(1.4*2));
        }
    }

    translate([-27.6,.1,case_bottom_height])
        cube([23, 1, .7]);

    translate([4.4,.1,case_bottom_height])
        cube([23, 1, .7]);

    translate([4.4,-.2,case_bottom_height])
        cube([1, 1.3, .7]);

}

module simple_case(width = 27.4, length = 54.5) {
    h=7.7;

    translate([-length/2, width, 0])
    rotate([0,0,90+180])
    difference() {
        cube([width, length, h]);
        translate([1.4,1.4,case_bottom_height])
            cube([width-(1.4*2)+1.5, length-(1.4*2), h]);
    }

    translate([-length/2,0,case_bottom_height])
        cube([23, 1, 1]);
    translate([-length/2,0,case_bottom_height])
        cube([5, 1, 4]);

    translate([length/2-23,0,case_bottom_height])
        cube([23, 1, 1]);
    translate([length/2-5,0,case_bottom_height])
        cube([5, 1, 4]);

    slider_depth=.5;
    translate([length/2-23,-slider_depth, 1])
        cube([1.3, slider_depth, case_bottom_height]);


    *translate([4.4,-.2,case_bottom_height])
        cube([1, 1.3, .7]);
    *translate([-length/2,0,case_bottom_height])
        cube([length, 1, 1]);

    translate([-length/2,width,0])
        cube([length, .4, h]);

    translate([-length/2,width+.4,h])
        rotate([0,90,0])
            linear_extrude(height=length)
                polygon(points=[
                        [0,0.4],
                        [0,0],
                        [h,0],
                    ]);
}

// test .5 and .2

module pin(add = .1) { // add=0 is too lose (exact match)
    difference() {
        linear_extrude(height=10.3)
            polygon(points=[
                    [0, 0],
                    [0, 5 + add],
                    [6 + add, 3 + add],
                    [6 + add, 0],
                ]);

        *translate([1.5,1.5,4.9])
            cube([3, 5, 10.3]);
    }
}

module holder(distance, diameter=4.2, thickness=1.5) {
    difference() {
        translate([-distance,0,0])
            cube([distance,thickness,4.9]);

        union() {
            translate([-distance/2,0,diameter/2+1])
                rotate([90,0,0])
                    cylinder(d=diameter, h=10, center=true, $fn=100);

            offset = .5;
            translate([-distance/2-(diameter-offset)/2,-5,3])
                cube([diameter-offset,10,5]);
        }
    }
}

module pins() {
    distance=7.75;
    translate([distance/2,0,0])
        union() {
            *translate([-15,0,-1])
                cube([22,5.5, 1]);
            pin();

            translate([-distance,0,0])
                mirror([1,0,0])
                    translate([0,0,0])
                        pin();

            holder(distance, diameter=4.2);
        }
}

module button() {
    width = 26.5; length = 54.5;
    union() {
        simple_case(width=width,length=length);
        //case();
    }

    translate([0, width - 23.7, case_bottom_height]) {
        pins();
    }


    translate([7.75/2, width-4.6, case_bottom_height])
        holder(7.75, diameter=4.2);

    middle_holder_thickness=3;
    translate([7.75/2,width-9.5-middle_holder_thickness,case_bottom_height]) {
        holder(7.75, thickness=middle_holder_thickness, diameter=4.2);

        l=6;
        cube([l,3,4.9]);
        translate([-7.75-l,0,0])
        cube([l,3,4.9]);
    }

}

button();