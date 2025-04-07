// Æthervox v1-lynx case
$fn = 64;
pcb = [86.5, 15.75, 2];
switch = [7.5, 15, 8.5];
switch_pin = [3.5, 3.75, 3.5];
switch_dy = 2.5*switch_pin.y;
switch_dx = 34.5;
ctop = [13.5, 11, 11];
pins = [0, 7, 2.5];
wall = 2;

shelldia = 25;
shelldia_s = shelldia / 1.307 * 1.207;
shellpcb_dz = -ctop.y/2+pcb.z/3;
shellcutoutdia = shelldia/2-switch.z-shellpcb_dz-pcb.z;

xlr = [16, 16.75, 1];
xlr_pin = [1.5, 45];
xlr_depth = 6.75;
xlr_conn_depth = [13.5, 12.25, 3];
xlr_screw = 3;
xlr_f = [6, 4, 1.5];
xlr_f_dz = 2.5;
xlr_fp = [1.5, 2];

xlr_dist = 20;

shellxlrdepth = xlr_depth+xlr_conn_depth.x + wall + xlr_dist;

module pcb(){
	union(){
		cube(pcb);
		translate([0, pcb.y/2-switch.y/2, pcb.z]) cube([pcb.x - switch_dx - switch.x, 0, 0] + switch);
		translate([pcb.x-switch_dx-switch.x, pcb.y/2-switch_dy/2, pcb.z+switch.z]) cube([2, 1.5*switch_pin.y, 0] + switch_pin);
		translate([0, pcb.y/2-switch_pin.y/2, pcb.z+switch.z]) cube([pcb.x - switch_dx - switch.x, 0, 0] + switch_pin);
		translate([0, pcb.y/2-pins.y/2, -pins.z]) cube([pcb.x, 0, 0] + pins);
		translate([pcb.x-switch_dx, pcb.y/2-ctop.y/2, 0]) cube([switch_dx, 0, 0] + ctop);
	}
}

module switch_cutout(){
	translate([0, -shelldia/2, 0]) rotate([-90, 0, 0]) cylinder(d=2*shellcutoutdia, h=shelldia);
}

module xlr(){
	rotate([90, 0, 90]) union(){
		cylinder(d=xlr.x, h=xlr_depth);
		rotate([0, 0, xlr_pin.y]) translate([0, xlr.x/2, 0]) cylinder(d=xlr_pin.x, h=xlr_depth);
		translate([-xlr_f.y/2, xlr.x/2-xlr_f_dz-xlr_f.z, xlr_depth]) rotate([90, 0, 0]) difference() {
			union(){
				cube([xlr_f.y, xlr_f.x - xlr_f.y, xlr_f.z]);
				translate([xlr_f.y/2, xlr_f.x - xlr_f.y, 0]) cylinder(d=xlr_f.y, h=xlr_f.z);
			}
			translate([xlr_f.y/2, xlr_f.x - xlr_f.y, 0]) cylinder(d=xlr_fp.x, h=xlr_fp.y);
		}
		translate([0, 0, xlr_depth/2]) rotate([-90, 0, 0]) cylinder(d=xlr_screw, h=xlr.x);
		translate([0, 0, -xlr_conn_depth.x]) {
			cylinder(d=xlr.x, h=xlr_conn_depth.x);
			translate([-xlr_conn_depth.z/2, xlr.x/2-xlr_conn_depth.z/2, xlr_conn_depth.x-xlr_conn_depth.y]) cube([xlr_conn_depth.z, xlr_conn_depth.z, xlr_conn_depth.z]);
			rotate([0, 0, xlr_pin.y]) translate([0, xlr.x/2, 0]) cylinder(d=xlr_pin.x, h=xlr_conn_depth.x);
		}
	}
}

module edge(h=20, d=5){
	difference(){
		cube([d, d, h]);
		cylinder(d=2*d, h=h);
	}
}

module shell(h=pcb.x+ctop.x+wall){
	difference(){
		rotate([0, 90, 0]) rotate([0, 0, 22.5]) cylinder(d=shelldia, h=h, $fn=8);
		for (i=[0:7]){
			rotate([45*i, 0, 0]) translate([h-1, 0, 0]) rotate([45, 0, 0]) translate([0, shelldia/2-1.95, -20]) edge(h=40, d=1);
		}
	}
}

module xlrshell(h=shellxlrdepth){
	shell(h=h);
}

module full(){
	difference(){
		union(){
			shell();
			rotate([0, 180, 0]) xlrshell();
		}
		translate([0, -pcb.y/2, shellpcb_dz]) pcb();

		mirror([1, 0, 0]) intersection(){
			translate([0, -pcb.y/2, shellpcb_dz]) pcb();
			shell(h=shellxlrdepth/2);
		}
		translate([-shellxlrdepth/2, 0, 0]) mirror([1, 0, 0]) intersection(){
			translate([0, -pcb.y/2, shellpcb_dz]) pcb();
			shell(h=shellxlrdepth/2);
		}

		translate([pcb.x-switch_dx-switch.x+(2+switch_pin.x)/2, 0, shelldia_s/2+shellcutoutdia/3]) switch_cutout();

		rotate([180, 0, 0]) translate([-xlr_depth-shellxlrdepth+xlr_depth+xlr_conn_depth.x, 0, 0]) xlr();

		translate([pcb.x+ctop.x-wall, -0.75, -shelldia_s/2-0.75]) mirror([1, 0, 0]) linear_extrude(1) offset(r=0.1) text("Æthervox v1-lynx", size=6.5, valign="center", font="monofur");

		//translate([-shellxlrdepth, 0, -30]) cube([300, 30, 60]);
	}
}

full();
