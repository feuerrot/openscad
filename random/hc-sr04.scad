// base with magnets for a HC-SR04 sensor
$fn = 16;
pcb = [45.5, 20.5, 1.2];   // pcb dimensions
pcb_h = [42.5, 17.5, 1.5]; // pcb hole dx, dy, diameter
pcb_mh = [5, 1.2];         // case mounting hole: depth, diameter (~1.5mm thread)
sensor = [12, 17.5, 26];   // sensor: height, diameter (+1.5mm wiggle), distance
crystal = [12.5, 5, 4];
magnet = [5.25, 2.5];
bottom = 5;
wall = 2;

module base(){
    translate([-(pcb.x/2 + wall), -(pcb.y/2 + bottom + wall), 0]) cube(pcb + [2*wall, 2*wall, 0] + [0, bottom, sensor.x]);
}

module pcb(){
    union(){
        translate([-pcb.x/2, -pcb.y/2, 0]) cube(pcb);

        for (dx=[-1,1], dy=[-1, 1]){
            translate([pcb_h.x/2*dx, pcb_h.y/2*dy, pcb.z]) cylinder(d=pcb_mh.y, h=pcb_mh.x);
            translate([sensor.z/2*dx, 0, pcb.z]) cylinder(d=sensor.y, h=sensor.x);
            translate([-crystal.x/2, -crystal.y/2 + (pcb.y/2-crystal.y/2)*dy, pcb.z]) cube(crystal);
        }
    }
}

module magnets(){
    for (dx=[-1, 1], dz=[-1, 1]){
        translate([(pcb.x/2 + wall/2 - magnet.x/2)*dx, -(pcb.y/2+bottom+wall), (pcb.z/2+sensor.x/2)+(pcb.z/2+sensor.x/2-wall/2-magnet.x/2)*dz]) rotate([-90, 0, 0]) cylinder(d=magnet.x, h=magnet.y);
    }
}

module all(){
    difference(){
        base();
        pcb();
        magnets();
    }
}

all();
