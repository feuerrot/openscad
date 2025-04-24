// Wandhalter für ein 4040 Aluprofil
$fn=64;
alu = [40, 8, 4.5];
wall_screw = [8.5, 4.5, 15];
alu_screw = [16.5, 8.5, 4.5];
insert_z = 20;
alu_screw_dz = 5;

difference(){
	union(){
		// base: cube
		cube([alu.x, alu.x, alu.x]);

		// base: holds alu insert in place
		translate([0, alu.x, alu.x/2 - alu_screw_dz - alu_screw.y/2]) difference(){
			cube([alu.x, alu.z, alu.y]);
			translate([alu.x/2-insert_z/2, 0, 0]) cube([insert_z, alu.z, alu.y]);
		}
	}

	// wall screw
	translate([alu.x/2, alu.x/2, alu.x-wall_screw.z]) union(){
		cylinder(d=wall_screw.y, h=wall_screw.z);
		translate([0, 0, -alu.x]) cylinder(d=wall_screw.x, h=alu.x);
	}

	// alu screw
	translate([alu.x/2, alu.x-alu_screw.z, alu.x/2-alu_screw_dz]) rotate([-90, 0, 0]) union(){
		cylinder(d=alu_screw.y, h=alu_screw.z);
		translate([0, 0, -alu.x]) cylinder(d=alu_screw.x, h=alu.x);
	}
}
