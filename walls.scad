$fn = 20;

apothem = 25 / 2;
diagonal = apothem * 2.3094;
genericTokenHeight = 40;

module cap(height, length, thickness) {
    cylinder(h = height - thickness / 2, d = thickness);
    translate(v = [0, 0, height - thickness / 2])
        sphere(d = thickness);
}

module foot(width = 4, length = 6, height = 1) {
    linear_extrude(height = height, center = false){
        square(size = [length - width, width], center = true);
        translate([ (length-width) / 2, 0, 0]) circle(d = width);
        translate([-(length-width) / 2, 0, 0]) circle(d = width);
    }
}

module wall(height = 10, length = 20, thickness = 2, opening = 0) {
    difference() {
        union() {
            // Main wall portion
            translate([ - thickness / 2, 0, 0 ])
                cube([thickness, length - thickness, height - thickness / 2]);
            // Add rounded top
            translate([0 , 0, height - thickness / 2]) rotate([-90, 0, 0]) 
                cylinder(h = length - thickness, d = thickness);
        }
        // Add opening if the wall has an opening
        if( opening > 0){
            translate([-thickness/2-1, length/2 - opening/2 - thickness/2, 2])
                cube([
                    thickness + 2, // wider to account for z-fighting
                    length > 30 ? 25 : length / 2,
                    height
                ]);
        }
    };


    // Add rounded ends
    cap(height, length, thickness);
    translate([0, length - thickness, 0]) cap(height, length, thickness);
    // Add feet
    footWidth = 2;
    if (length < 15) {
        translate([0, length/2 - thickness / 2, 0]) foot(length = length / 10);
    }
    else {
        translate([0, length - thickness * 2, 0]) foot(length = height / 3);
        translate([0, thickness, 0]) foot(length = height / 3);
    }
}

wall(height = 45,length =  diagonal *2, thickness = 3, opening = 25);
rotate(a = 180-45)
    wall(height = 20, length = diagonal, thickness = 2);
//foot();
