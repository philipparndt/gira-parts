$fn = 100; // render resolution

// parameters
bottom = 54;
top = 55;
h = 8.7;
border = 1.5;
bottom_thickness = 2; // new floor thickness

// computed inner sizes
inner_bottom = bottom - 2*border;
inner_top    = top    - 2*border;

// sanity check
if (inner_bottom <= 0 || inner_top <= 0)
    echo("ERROR: border too large for given dimensions");

module tapered_square(bottom_size, top_size, height) {
    hull() {
        translate([-bottom_size/2, -bottom_size/2, 0])
            cube([bottom_size, bottom_size, 0.01]);
        translate([-top_size/2, -top_size/2, height])
            cube([top_size, top_size, 0.01]);
    }
}

module case() {
    difference() {
        // outer tapered shell
        tapered_square(bottom, top, h);

        // inner hollow space (shifted up so bottom stays solid)
        translate([0, 0, bottom_thickness])
            tapered_square(inner_bottom, inner_top, h - bottom_thickness);
    }

    // add solid bottom plate
    translate([-inner_bottom/2, -inner_bottom/2, 0])
        cube([inner_bottom, inner_bottom, bottom_thickness]);
}

// case();

//linear_extrude(height=depth + previewOptimize * 2, center=false) {

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
                cylinder(d=2.5, h=10, center=false, $fn=100); // d3 is too much

            w=2;
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

module clips(width=1.4, length=5.9, distance=16) {
    d = distance + width;
    x=.5;
    translate([-d/2 + width/2,-length/2,-.1]) {
        clip(width=width, length=length);
        translate([d+x,0,0])
            clip(width=width+x, length=length);
    }
}


module button() {
    union() {
        for (i = [0:5]) {
            translate([0.75 * i, (i % 2) * 0.8, 0])
                cube([0.75, 2, 3.3]);
        }
    }
}

module buttons(distance=3.3) {
    width = 4.5;
    d = distance + width;

    translate([-d/2 + width/2,-2.8/2]) {
        mirror([1,0,0])
            button();

        translate([distance,0,0])
            button();
    }
}

module button_slim() {
    cube([3.2, 1, 1.3]);
}

module buttons_slim() {
    translate([-3.2/2,-1/2 - 20/2,0]) {
        button_slim();

        translate([0,20,0])
            button_slim();
    }
}

difference() {
    union() {
        difference() {
            translate([-13 + 5.8, 0, -2])
                case();

            translate([-56.1 - 1, -30, -3])
                cube([50, 70, 20], center = false);
        }

        translate([-6.3, 26, -1.5])
            rotate([90, 0, -90])
                linear_extrude(height = 0.8)  // extrusion height
                    polygon(points = [[0, 0], [9, 0], [0, 5]]);

        translate([-7.1, -26, -1.5])
            rotate([90, 0, 90])
                linear_extrude(height = 0.8)  // extrusion height
                    polygon(points = [[0, 0], [9, 0], [0, 5]]);

        //translate([0,0,-1])
//    cube([27.5,55,2], center=true);

        translate([4.35 - 1, 0, 0])
            clips();

        translate([7.6 - 2.5, 18.5, 0])
            buttons();

        translate([7.6 - 2.5, -18.5, 0])
            buttons();

        translate([12.2 - 6.5, 0, 0])
            buttons_slim();

    }
    translate([15, 20, -6])
        linear_extrude(height = 5)
            rotate([0, 0, 180])
                scale([0.1, 0.1, 1])  // shrink X/Y by 10%
                    import("Speaker_Icon.svg");
}