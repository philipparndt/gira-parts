use <./button.scad>

union() {
    *button();

    translate([0, 26.4/2, 0.1])
        cube([54.5, 26.4, 0.1], center = true);
}
