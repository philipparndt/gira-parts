use <./button.scad>

union() {
    *button();

    translate([-21+6, 16.5, .1])
        linear_extrude(height = .1)
            mirror([0,1,0])
                rotate([0, 0, 90])
                    scale([.8, .8, 1])
                        import("./lucide-scaled/play.svg");


    translate([28-6, 16.5, .1])
        linear_extrude(height = .1)
            mirror([0,1,0])
                rotate([0, 0, 90])
                    scale([.8, .8, 1])
                        import("./lucide-scaled/square.svg");

}
