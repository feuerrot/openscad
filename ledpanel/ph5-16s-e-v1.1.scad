$fn = 20;

// Choose either edge or center
edge = 1;
center = 0;

screw_left = 8;
screw_down = 8;
screw_inner = 3.3;
screw_outer = 6;
screw_height = 10;

base_height = 4;
border_height = 20;
border_width = 5;

module edge(){
	difference(){
		union(){
			if (edge){
				cube([screw_left + screw_outer + border_width, 2 * screw_down + border_width, border_height]);
				cube([screw_left + screw_outer + border_width, 2 * screw_down, screw_height]);
			} else {
				cube([3 * screw_left, 3 * screw_down, screw_height]);
			}
		}
		if (edge){
			translate([0, 0, screw_height]) cube([screw_left + screw_outer + border_width, 2 * screw_down, screw_height]);
		}
		translate([screw_left, screw_down, 0]) cylinder(h = screw_height, d = screw_inner);
	}
}

union(){
	union(){
		edge();
		mirror([1, 0, 0]) edge();
	}
	if (center){
		mirror([0, 1, 0]) union(){
			edge();
			mirror([1, 0, 0]) edge();
		}
	}
}
