pcb = [42.75, 90, 2.1];
wall = 2;
halter = [3, 7.5, 2.5];
usb = [9.5, 3.75, 25.5];
led = [10, 4, 0];

luftloch = [5, 2, 0];

module main(){
	difference(){
		cube(pcb + 2*[wall, wall, wall] + [0, 0, halter.x + halter.y]);
		translate([wall, wall, wall]) difference() {
			cube(pcb + [0, 0, halter.x + halter.y]);

			cube([halter.z, pcb.y + 2*wall, halter.x]);
			translate([pcb.x-halter.z, 0, 0]) cube([halter.z, pcb.y + 2*wall, halter.x]);
			translate([0, 0, halter.x + pcb.z]) cube([halter.z, pcb.y + 2*wall, halter.y]);
			translate([pcb.x-halter.z, 0, halter.x + pcb.z]) cube([halter.z, pcb.y + 2*wall, halter.y]);
		}
		translate([wall, 0, wall] + [usb.z + 0.125, 0, halter.x + pcb.z - 0.25]) cube([usb.x, wall, usb.y]);
		translate([wall, 0, wall] + [led.x + led.y/2 + 0.125, 0, halter.x + pcb.z/2]) rotate([-90, 0, 0]) cylinder(d=led.y, h=wall, $fn=8);

		// Anzahl = floor(ganze Breite / (Breite + Abstand))
		xn = floor((pcb.x - 2*halter.z)/(luftloch.x + luftloch.y));
		xabst = (pcb.x - 2*halter.z - xn*luftloch.x)/xn;
		yn = floor((pcb.y - 2*halter.z)/(luftloch.x + luftloch.y));
		yabst = (pcb.y - 2*halter.z - yn*luftloch.x)/yn;

		translate([wall + 2*halter.z, wall + 2*halter.z, wall + halter.x + halter.y + pcb.z]) for (i = [0:xn-1]) { 
			for (y = [0:yn-1]) {
				translate([xabst/2 + i*(luftloch.x+xabst), yabst/2 + y*(luftloch.x + yabst), 0]) cylinder(d=luftloch.x, h=wall, $fn=6);
			}
		}

		translate([wall + 2*halter.z, wall + 2*halter.z, wall + halter.x + halter.y + pcb.z]) for (i = [0:xn-2]) { 
			for (y = [0:yn-2]) {
				translate([xabst*2 + i*(luftloch.x+xabst), yabst*2.25 + y*(luftloch.x + yabst), 0]) cylinder(d=luftloch.x, h=wall, $fn=6);
			}
		}

		translate([0, pcb.y+wall, 0]) cube([100, 100, 100]);
	}
}

module cover() {
	difference(){
	union(){
		translate([0, -wall, 0]) cube([pcb.x, 0, pcb.z] + [2*wall, 2*wall, 2*wall] + [0, 0, halter.x + halter.y]);
		translate([wall, wall, wall]) union() {
			translate([halter.z, 0, 0]) cube([halter.z, 10, halter.x]);
			translate([pcb.x-2*halter.z, 0, 0]) cube([halter.z, 10, halter.x]);
			translate([halter.z, 0, halter.x]) cube([halter.z, 6, pcb.z]);
			translate([pcb.x-2*halter.z, 0, halter.x]) cube([halter.z, 6, pcb.z]);
			translate([halter.z, 0, halter.x + pcb.z]) cube([halter.z, 3, halter.y]);
			translate([pcb.x-2*halter.z, 0, halter.x + pcb.z]) cube([halter.z, 3, halter.y]);

			translate([halter.z, 0, halter.x + halter.y + pcb.z - halter.z]) cube([pcb.x-2*halter.z, 3, halter.z]);
		}
	}

	translate([wall, 0, wall] + [pcb.x/2, 0, halter.x + halter.y + pcb.z - 9.5/2]) rotate([-90, 0, 0]) union(){
		cylinder(d=9.5, h=3+wall, $fn=6);
		translate([0, 0, -wall]) cylinder(d=6.5, h=3+wall, $fn=16);
		translate([0, 0, -wall]) cylinder(d=10, h=wall/2, $fn=16);
	}
	}
}

main();