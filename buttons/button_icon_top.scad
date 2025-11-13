use <./button.scad>
use <./button_icon_cfg.scad>

difference() {
    union() {
        *button();

        translate([-21+6, 16.5, 0])
            linear_extrude(height = cutout_top() != false ? 0.3 : 0.2)
                mirror([0,1,0])
                    rotate([0, 0, 90])
                        scale([.8, .8, 1])
                            import(top());
    }

    // Subtract cutout from top icon
    if (cutout_top() != false) {
        translate([-21+6, 16.5, 0])
            linear_extrude(height = 0.1)
                mirror([0,1,0])
                    rotate([0, 0, 90])
                        scale([.8, .8, 1])
                            import(cutout_top());
    }
}
