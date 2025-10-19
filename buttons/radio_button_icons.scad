use <./button.scad>

union() {
    *button();

    translate([-21+6, 16.5, 0])
        linear_extrude(height = .2)
            mirror([0,1,0])
                rotate([0, 0, 90])
                    scale([.8, .8, 1])
                        import("./lucide/stroke/1.0/play.svg");

    translate([28-6, 16.5, 0])
        linear_extrude(height = .2)
            mirror([0,1,0])
                rotate([0, 0, 90])
                    scale([.8, .8, 1])
                        import("./lucide/stroke/1.0/square.svg");

}
