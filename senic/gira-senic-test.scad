$fn = 100; // render resolution

module clip(width=2, length=5.9) {
    union() {
    rotate([0,-90,0])
    difference() {
        linear_extrude(width) // 1.5 would be ideal but I guess it is too thing to provide the structural integrity
            polygon(points=[
                    [0, 0],
                    [0, length],
                    [3, length-.1],
                    [3.65, length - 1],

                    [3.65, 1],
                    [3, 0.1],
                ]);

        union() {
            translate([2,length/2,-5])
                cylinder(d=2.4, h=10, center=false, $fn=100); // d3 is too much

            w=1.8;
            translate([2,length/2 - w/2,-5])
                cube([2,w,10], center=false);
        }
    }


    hook=.6;
    translate([0,0,hook])
    rotate([90,180,180])
    linear_extrude(length)
    polygon(points=[
            [0, 0],
            [0, hook],
            [hook, hook],
        ]);

    translate([-width,length,hook])
    rotate([90,180,0])
        linear_extrude(length)
            polygon(points=[
                    [0, 0],
                    [0, hook],
                    [hook, hook],
                ]);
    }
}

translate([0,15,0])
difference() {
    translate([0,10,0])
        clip(width=1.4);

    translate([-.8,9,1])
        cube([.1,8,10]);
}

clip(width=1.4);

rotate([0,90,0])
translate([5,0,5]) {
    translate([0,15,0])
        difference() {
            translate([0,10,0])
                clip(width=1.4);

            translate([-.7,9,1])
                cube([.1,8,10]);
        }

    clip(width=1.4);
}

translate([-3,-6,-8])
cube([8,40,8]);