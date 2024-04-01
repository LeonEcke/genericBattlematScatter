apothem = 25 / 2;
diagonal = apothem * 2.3094;
halfDiagonal = diagonal / 2;
point = halfDiagonal * 0.25;
flat = halfDiagonal - point;
sideTranslation = halfDiagonal + point*2;

module single(h = 10){
    cylinder(h -1, d = diagonal, $fn = 6); // mother hexagon
    translate([0, 0, h -1]) cylinder(0.5, d = diagonal - 1, $fn = 6);
}

module double(h = 10){
    translate([ 0, apothem, 0]) single(h);
    translate([ 0, -apothem, 0]) single(h);
}

module triple(h = 10){
    translate([halfDiagonal - point, 0, 0]) double(h);
    translate([-flat, 0, 0]) single(h);
}

module triCurve(h = 10){
    translate([0,apothem, 0]) single(h);
    translate([sideTranslation, 0, 0]) single(h);
    translate([-sideTranslation, 0, 0]) single(h);
}

module quadCurve(h = 10){
    translate([0, apothem, 0]) triCurve(h);
    translate([-sideTranslation, -apothem, 0]) single(h);
}

module quintuple(h = 10){
    translate([0, 0, 0]) quadCurve(h);
    translate([0, 0, 0]) single(h);
}

module quintCurve(h = 10){
    translate([0, 0, 0]) quadCurve(h);
    translate([0, -apothem*2, 0]) single(h);
}

module fullCurve(h = 10){
    translate([0, 0, 0]) quintCurve(h);
    translate([sideTranslation, -apothem, 0]) single(h);
}

module fullBig(h = 10){
    translate([0, 0, 0]) fullCurve(h);
    translate([0, 0, 0]) single(h);
}

translate([80 * 0, 0, 0]) single();
translate([80 * 1, 0, 0]) double();
translate([80 * 2, 0, 0]) triple();
translate([80 * 3, 0, 0]) quintuple();
translate([80 * 4, 0, 0]) fullBig();

translate([80 * 0, 80, 0]) triCurve();
translate([80 * 1, 80, 0]) quadCurve();
translate([80 * 2, 80, 0]) quintCurve();
translate([80 * 3, 80, 0]) fullCurve();
