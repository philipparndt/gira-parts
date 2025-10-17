
Mtolerance = 0.1;
M5size = 7.8;

function M5() = M5size + Mtolerance;

// Fits a standard M2.5 nut when printed with PLA the nut does not fall out
function M2_5_Pla() = 4.95 + Mtolerance;

// Fits a standard M2.5 nut. The nut falls out. Ideal for metal printing
function M2_5() = 5.05 + Mtolerance;

module hexHole(flatToFlatDistance, depth) {
    previewOptimize = 0.1;
    hexagonSide = flatToFlatDistance / (cos(30) * 2);

    translate([0, 0, -previewOptimize]) {
        linear_extrude(height=depth + previewOptimize * 2, center=false) {
            polygon(points=[
                    [hexagonSide, 0],
                    [hexagonSide / 2, sqrt(3) * hexagonSide / 2],
                    [-hexagonSide / 2, sqrt(3) * hexagonSide / 2],
                    [-hexagonSide, 0],
                    [-hexagonSide / 2, -sqrt(3) * hexagonSide / 2],
                    [hexagonSide / 2, -sqrt(3) * hexagonSide / 2]
                ]);
        }
    }
}

// Rounded rectangle module
module rounded_rectangle(width, length, r, fn=64) {
    // ensure radius doesn't exceed half of width/height
    rr = min(r, width/2, length/2);

    translate([rr, rr])
        offset(r=rr, $fn=fn)
            square([width - 2*rr, length - 2*rr]);

}
