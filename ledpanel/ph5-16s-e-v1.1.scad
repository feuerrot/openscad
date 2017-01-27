$fn = 20;

screw_left = 8;
screw_down = 8;
screw_inner = 3.3;
screw_outer = 6;
screw_height = 10;

base_height = 4;
border_height = 20;
border_width = 5;

module content(){
	difference(){
		union(){
			cube([screw_left + screw_outer + border_width, 2 * screw_down + border_width, border_height]);
			translate([screw_left, screw_down, 0]) cylinder(h = screw_height, d = screw_outer);
		}
		translate([0, 0, screw_height]) cube([screw_left + screw_outer + border_width, 2 * screw_down, screw_height]);
		translate([screw_left, screw_down, 0]) cylinder(h = screw_height, d = screw_inner);
	}
}

union(){
	union(){
		content();
		mirror([1, 0, 0]) content();
	}
}
