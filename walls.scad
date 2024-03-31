$fn = 20;

apothem = 25 / 2;
diagonal = apothem * 2.3094;

module cap(height, length, thickness) {
    cylinder(h = height - thickness / 2, d = thickness);
    translate(v = [0, 0, height - thickness / 2])
        sphere(d = thickness);
}

module wall(height = 10, length = 20, thickness = 2) {
    // Main wall portion
    translate([ - thickness / 2, 0, 0 ])
        cube([thickness, length - thickness, height - thickness / 2]);
    // TODO: Add feet

    // Add rounded top
    translate([0 , 0, height - thickness / 2]) rotate([-90, 0, 0]) 
            cylinder(h = length - thickness, d = thickness);
    // Add rounded ends
    cap(height, length, thickness);
    translate([0, length - thickness, 0]) cap(height, length, thickness);
}

wall(10, 20);
