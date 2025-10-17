

use <./button.scad>

difference() {
    button();

    translate([-21+6, 16.5, 0])
        linear_extrude(height = 1)
            mirror([0,1,0])
                rotate([0, 0, 90])
                    scale([1, 1, 1])
                        import("./lucide-converted-scaled/panel-top-bottom-dashed.svg");

    translate([28-12, 10, 0])
        linear_extrude(height = 1)
            mirror([0,1,0])
                rotate([0, 0, -90])
                    scale([1, 1, 1])
                        import("./lucide-converted-scaled/arrow-up.svg");
}
