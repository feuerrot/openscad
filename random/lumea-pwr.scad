// replacement bottom cover for 4mm banana plug sockets (Pollin 451956) for some Philips Lumea IPL device
$fn=64;
sock_bot = [11, 3];
sock_top = [8.5, 8];
screw = [4.25, 2.5, 2]; // head dia, thread dia, head height
screw_dx = 28.5; // offset
screw_dy = 19;   // distance
oval = [47.5, 31.5, 37]; // z: usable space in x
bottom = 5;
wall = 2;

xt_screw = [6, 2.5, 4, 1.5];
xt_outer = [27.5, 12.25, 4];
xt_inner = [15.75, 8.25, 3];
xt_holedx = 20.5;
xt_r = 3;

module radius(r=1, h=1){
    difference(){
        cube([r, r, h]);
        cylinder(r=r, h=h);
    }
}

module bananaplug(){
    difference(){
        base();

        translate([-(sock_bot.x/2 + wall), 0, 0]){
            cylinder(d=sock_top.x, h=bottom);
            translate([0, 0, bottom-sock_bot.y]) cylinder(d=sock_bot.x, h=sock_bot.y);
        }
        translate([+(sock_bot.x/2 + wall), 0, 0]){
            cylinder(d=sock_top.x, h=bottom);
            translate([0, 0, bottom-sock_bot.y]) cylinder(d=sock_bot.x, h=sock_bot.y);
        }
    }
}

module xt60_conn(){
    translate([0, 0, bottom-xt_inner.z]) union(){
        translate([-xt_outer.x/2, -xt_outer.y/2, -xt_outer.z]) cube(xt_outer);
        difference(){
            translate([-xt_inner.x/2, -xt_inner.y/2, 0]) cube(xt_inner);
            translate([xt_inner.x/2-xt_r, xt_inner.y/2-xt_r, 0]) radius(r=xt_r, h=xt_inner.z);
            translate([xt_inner.x/2-xt_r, -xt_inner.y/2+xt_r, 0]) rotate([0, 0, -90]) radius(r=xt_r, h=xt_inner.z);
        }
        translate([xt_holedx/2, 0, -xt_inner.z]) cylinder(d=xt_screw.y, h=xt_screw.x);
        translate([-xt_holedx/2, 0, -xt_inner.z]) cylinder(d=xt_screw.y, h=xt_screw.x);
        translate([xt_holedx/2, 0, xt_inner.z-xt_screw[3]]) cylinder(d1=xt_screw.y, d2=xt_screw.z, h=xt_screw[3]);
        translate([-xt_holedx/2, 0, xt_inner.z-xt_screw[3]]) cylinder(d1=xt_screw.y, d2=xt_screw.z, h=xt_screw[3]);
    }
}

module xt60(){
    difference(){
        base();
        xt60_conn();
        translate([-xt_inner.x/2-2*wall-2*xt_screw.y, -6.5/2+2.75, bottom-0.25]) linear_extrude(1) offset(r=0.1) text("+", size=6.5, halign="center", valign="center", font="Source Code Pro");
        translate([xt_inner.x/2+2*wall+2*xt_screw.y, -1.4, bottom-0.25]) linear_extrude(1) offset(r=0.1) text("-", size=6.5, halign="center", valign="center", font="Source Code Pro");
    }
}

module base(){
    difference(){
        resize([oval.x, oval.y]) cylinder(d=oval.x, h=bottom);

        translate([screw_dx-oval.x/2, screw_dy/2, 0]) {
            translate([0, 0, bottom - screw.z]) cylinder(d=screw.x, h=screw.z);
            cylinder(d=screw.y, h=bottom);
        }
        translate([screw_dx-oval.x/2, -screw_dy/2, 0]) {
            translate([0, 0, bottom - screw.z]) cylinder(d=screw.x, h=screw.z);
            cylinder(d=screw.y, h=bottom);
        }
    }
}

xt60();
