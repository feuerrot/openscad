//
$fn=32;
base = [6.5, 40, 10];
wall = 5;
a = 22.5;
hdist = [10, 11, 5];

module bconn(){
    union(){
        difference(){
            cube(base + [2*wall, 2*wall, 0]);
            translate([wall, wall, 0]) cube(base);
            translate([0, wall, 0]) cube([wall, base.y- 0.5*wall, base.z]);
        }
        translate([wall/2, 0.9*wall, 0]) cylinder(d=wall, h=base.z);
    }
}

module lconn(){
    difference(){
        cube([hdist.x+hdist.y+hdist.z, wall, base.z]);
        translate([hdist.x, 0, base.z/2]) rotate([-90, 0, 0]) cylinder(d=4, h=wall);
        translate([hdist.x+hdist.y, 0, base.z/2]) rotate([-90, 0, 0]) cylinder(d=4, h=wall);
    }

}

union(){
    bconn();
    translate([base.x+2*wall, base.y+wall, 0]) rotate([0, 0, a]) lconn();
}