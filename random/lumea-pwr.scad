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

module all(){
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

all();