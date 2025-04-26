// Föhnhalter, vong Bad her
$fn=64;
ring = [130, 20];
wall = 12.5;
chole = [5.25, 21, 19];
crot = -45;
shole = [4, 9, 2];
wallcube = [30, 12.5];
alu = [40, 8, 4.5];
alu_screw = [16.5, 8.5, 15];
insert_z = 20;

difference(){
	union(){
		difference(){
			cylinder(d=ring.x + 2*wall, h=ring.y);
			cylinder(d=ring.x, h=ring.y);
		}
		translate([-wallcube.x/2, ring.x/2+wall/2, 0]) cube([wallcube.x, wallcube.y, ring.y]);
		translate([-wallcube.x/2, ring.x/2+wallcube.y + wall/2, ring.y/2-alu.y/2]) difference(){
			 cube([wallcube.x, alu.z, alu.y]);
			 translate([wallcube.x/2-insert_z/2, 0, 0]) cube([insert_z, alu.z, alu.y]);

		}
	}

	translate([0, ring.x/2 - wallcube.y/2, ring.y/2]) rotate([-90, 0, 0]) cylinder(d=alu_screw.y, h=wallcube.y*2);
	translate([0, ring.x/2 - 1.25, ring.y/2]) rotate([-90, 0, 0]) cylinder(d=alu_screw.x, h=alu_screw.z);
}