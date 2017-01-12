$fn = 200;

a_left = 7.5;
a_down = 30;
a_inner = 3.2;
a_outer = 6;
a_height = 8;

b_left = 35;
b_down = 7.5;
b_inner = 3.2;
b_outer = 6;
b_height = 8;

base_height = 2;

module content(){
	difference(){
		union(){
			linear_extrude(height = base_height) polygon(
				points = [
					[0, 0],
					[0, a_down + a_outer],
					[a_left + a_outer, a_down + a_outer],
					[b_left + b_outer, b_down + b_outer],
					[b_left + b_outer, 0]
				]
			);
			translate([a_left, a_down, 0]) cylinder(h = a_height, d = a_outer);
			translate([b_left, b_down, 0]) cylinder(h = b_height, d = b_outer);
		}
		translate([a_left, a_down, 0]) cylinder(h = a_height, d = a_inner);
		translate([b_left, b_down, 0]) cylinder(h = b_height, d = b_inner);
	}
}

union(){
	union(){
		content();
		mirror([1, 0, 0]) content();
	}
	mirror([0, 1, 0]) union(){
		content();
		mirror([1, 0, 0]) content();
	}
}
