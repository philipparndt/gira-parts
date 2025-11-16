use <./button.scad>
use <./button_icon_cfg.scad>

difference() {
    union() {
        *button();

        translate([-21+6, 16.5, 0])
            linear_extrude(height = .3)
                mirror([0,1,0])
                    rotate([0, 0, 90])
                        scale([.8, .8, 1])
                            import(get_top());

        translate([28-6, 16.5, 0])
            linear_extrude(height = .3)
                mirror([0,1,0])
                    rotate([0, 0, 90])
                        scale([.8, .8, 1])
                            import(get_bottom());
    }

}
